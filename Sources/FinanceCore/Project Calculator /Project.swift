//
//  Project.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 29/09/2025.
//

import Foundation

public class Project: Identifiable, Equatable, Hashable {
    public var id: UUID = .init()
    public var name: String
    public var iconName: String? = nil
    public var creationDate: Date = .now
    public var deadline: Date
    public var goalAmount: Decimal
    public var transactions: [Transaction] = []
    public var currency: CurrencyAvailable = .eur
    public var startedDate: Date = .now
    public var minimumInvestment: Decimal = 0
    public var amountSaved: Decimal = 0.0
    
    // MARK: - Formatage
    public var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let number = NSDecimalNumber(decimal: amountSaved)
        let formatted = formatter.string(from: number) ?? "\(amountSaved)"
        
        return "\(formatted)\(currency.symbol)"
    }
    
    // MARK: - Initialisations principales
    public init(name: String, finalDate: Date, amount: Decimal) {
        self.name = name
        self.deadline = finalDate
        self.goalAmount = amount
        let months = DateCalculator.monthsBetween(startedDate, deadline)
    }
    
    public init(name: String, finalDate: Date, amount: Decimal, transactions: [Transaction]) {
        self.name = name
        self.deadline = finalDate
        self.goalAmount = amount
        self.transactions = transactions
        let months = DateCalculator.monthsBetween(startedDate, deadline)
    }
    
    public init(name: String, finalDate: Date, amount: Decimal, transactions: [Transaction], currency: CurrencyAvailable) {
        self.name = name
        self.deadline = finalDate
        self.goalAmount = amount
        self.transactions = transactions
        self.currency = currency
        let months = DateCalculator.monthsBetween(startedDate, deadline)
        
    }
    
    public init(name: String,
                creationDate: Date = .now,
                finalDate: Date,
                amount: Decimal,
                transactions: [Transaction] = [],
                currency: CurrencyAvailable,
                scheduler: Scheduler) {
        self.name = name
        self.deadline = finalDate
        self.goalAmount = amount
        self.transactions = transactions
        self.currency = currency
        self.creationDate = creationDate
    }
    
    public init(name: String, iconName: String, finalDate: Date, amount: Decimal) {
        self.name = name
        self.deadline = finalDate
        self.goalAmount = amount
        
    }
    
    // MARK: - Égalité / hash
    public static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.name == rhs.name &&
        lhs.deadline == rhs.deadline &&
        lhs.goalAmount == rhs.goalAmount &&
        lhs.transactions == rhs.transactions
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // MARK: - Transactions
    public func addTransaction(_ amount: Decimal, date: Date? = nil) throws {
        guard amount != 0 else { throw TransactionError.invalidAmount(amount) }
        let newTransaction = Transaction(
            date: date ?? .now,
            amount: amount,
            category: .income(.ponctuel)
        )
        transactions.append(newTransaction)
    }
    
    public func addCashWithdrawal(_ amount: Decimal, date: Date? = nil) throws {
        guard amount != 0 else { throw TransactionError.invalidAmount(amount) }
        guard amountSaved - amount >= 0 else { throw TransactionError.insufficientFunds }
        let newTransaction = Transaction(
            date: date ?? .now,
            amount: -amount,
            category: .expense(.other)
        )
        transactions.append(newTransaction)
    }
    
    // MARK: - Modifications
    public func updateName(_ name: String) {
        guard !name.isEmpty, name != self.name else { return }
        self.name = name
    }
    
    public func updateDate(_ date: Date) {
        guard date != self.deadline else { return }
        self.deadline = date
    }
    
    public func updateIcon(_ iconName: String) {
        guard iconName != self.iconName else { return }
        self.iconName = iconName
    }
    
    // MARK: - Calculs
    public func feasibilityCalculation(_ amount: Decimal) -> Bool {
        let numberOfMonths = DateCalculator.monthsBetween(startedDate, deadline)
        self.minimumInvestment = goalAmount / Decimal(numberOfMonths)
        return minimumInvestment <= amount
    }
    
    // MARK: - Conversion vers ProjectData
    public func toProjectData(userId: UUID) -> ProjectData {
        ProjectData(
            id: self.id,
            name: self.name,
            iconName: self.iconName ?? "",
            creationDate: self.creationDate,
            endDate: self.deadline,
            amountSaved: NSDecimalNumber(decimal: self.amountSaved).doubleValue,
            amountTotal: NSDecimalNumber(decimal: self.goalAmount).doubleValue,
            userID: userId
        )
    }
}
