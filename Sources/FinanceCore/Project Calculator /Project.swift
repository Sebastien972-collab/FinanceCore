//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 29/09/2025.
//

import Foundation

public class Project: Identifiable, Equatable, Hashable {
    public private(set) var id: UUID = .init()
    public private(set) var name: String
    public private(set) var currentImage: String?
    public private(set) var deadline: Date
    public private(set) var goalAmount: Decimal
    public private(set) var transactions: [Transaction] = []
    public private(set) var currency: CurrencyAvailable = .eur
    public private(set) var startedDate: Date = .now
    public private(set) var minimumInvestment: Decimal = 0
    public private(set) var scheduler: Scheduler
    public private(set) var iconName: String? = nil
    public var amountSaved: Decimal {
        transactions.reduce(Decimal(0)) { $0 + $1.amount }
    }
    public var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        let number = NSDecimalNumber(decimal: amountSaved)
        let formatted = formatter.string(from: number) ?? "\(amountSaved)"
        
        return "\(formatted)\(currency.symbol)"
    }
    
    public init(name: String, currentImage: String? = nil, finalDate: Date, amount: Decimal) {
        self.name = name
        self.currentImage = currentImage
        self.deadline = finalDate
        self.goalAmount = amount
        let months = DateCalculator.monthsBetween(startedDate, deadline)
        self.scheduler = Scheduler(
            startDate: .now,
            monthlyAmount: goalAmount / Decimal(months),
            totalMonths: months
        )
    }
    public init(name: String, currentImage: String? = nil, finalDate: Date, amount: Decimal, transactions: [Transaction]) {
        self.name = name
        self.currentImage = currentImage
        self.deadline = finalDate
        self.goalAmount = amount
        self.transactions = transactions
        let months = DateCalculator.monthsBetween(startedDate, deadline)
        self.scheduler = Scheduler(
            startDate: .now,
            monthlyAmount: goalAmount / Decimal(months),
            totalMonths: months
        )
    }
    public init(name: String, currentImage: String? = nil, finalDate: Date, amount: Decimal, transactions: [Transaction], currency: CurrencyAvailable) {
        self.name = name
        self.currentImage = currentImage
        self.deadline = finalDate
        self.goalAmount = amount
        self.transactions = transactions
        self.currency = currency
        let months = DateCalculator.monthsBetween(startedDate, deadline)
        self.scheduler = Scheduler(
            startDate: .now,
            monthlyAmount: goalAmount / Decimal(months),
            totalMonths: months
        )
    }
    public init(name: String, currentImage: String? = nil, finalDate: Date, amount: Decimal, transactions: [Transaction], currency: CurrencyAvailable, scheduler: Scheduler) {
        self.name = name
        self.currentImage = currentImage
        self.deadline = finalDate
        self.goalAmount = amount
        self.transactions = transactions
        self.currency = currency
        let months = DateCalculator.monthsBetween(startedDate, deadline)
        self.scheduler = Scheduler(
            startDate: .now,
            monthlyAmount: goalAmount / Decimal(months),
            totalMonths: months)
    }
    public static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.name == rhs.name && lhs.deadline == rhs.deadline && lhs.goalAmount == rhs.goalAmount && lhs.transactions == rhs.transactions
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    public func addTransaction(_ amount: Decimal, date: Date? = nil) throws {
        guard amount != 0 else {  throw TransactionError.invalidAmount(amount) }
        let newTransaction = Transaction(date: date ?? .now, amount: amount, category: .income(.ponctuel))
        transactions.append(newTransaction)
    }
    public func addCashWithdrawal(_ amount: Decimal, date: Date? = nil) throws {
        guard amount != 0 else { throw TransactionError.invalidAmount(amount) }
        guard amountSaved - amount >= 0 else { throw TransactionError.insufficientFunds}
        let newTransaction = Transaction(date: date ?? .now, amount: -amount, category: .expense(.other))
        transactions.append(newTransaction)
        
    }
    public func updateName(_ name: String) {
        guard !name.isEmpty, name != self.name else { return }
        self.name = name
    }
    public func updateDate(_ date: Date) {
        guard date != self.deadline else { return }
        self.deadline = date
    }
    
    //    public func feasibilityCalculation(_ availableSavingsCapacity: Decimal) -> FeasibilityAnswer {
    //        FeasibilityAnswer.positiveAnswer
    //    }
    
    func setupScheduler(_ asc: Decimal)  {
        let monthlyAmount = goalAmount / Decimal(DateCalculator.monthsBetween(startedDate, deadline))
        if monthlyAmount < asc {
            
        }
    }
    public func feasibilityCalculation(_ amount: Decimal) -> Bool {
        let numberOfMonths = DateCalculator.monthsBetween(startedDate, deadline)
        self.minimumInvestment = goalAmount / Decimal(numberOfMonths)
        return minimumInvestment <= amount
    }
    
    public func updateIcon(_ iconName: String) {
        guard iconName != self.iconName else { return }
        self.iconName = iconName
    }
    
}
