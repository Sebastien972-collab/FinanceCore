//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 29/09/2025.
//

import Foundation

public struct Project {
    public private(set) var name: String
    public private(set) var currentImage: String?
    public private(set) var deadline: Date
    public private(set) var goalAmount: Decimal
    public private(set) var transactions: [Transaction] = []
    public private(set) var currency: CurrencyAvailable = .eur
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
    }
    public init(name: String, currentImage: String? = nil, finalDate: Date, amount: Decimal, transactions: [Transaction]) {
        self.name = name
        self.currentImage = currentImage
        self.deadline = finalDate
        self.goalAmount = amount
        self.transactions = transactions
    }
    public init(name: String, currentImage: String? = nil, finalDate: Date, amount: Decimal, transactions: [Transaction], currency: CurrencyAvailable) {
        self.name = name
        self.currentImage = currentImage
        self.deadline = finalDate
        self.goalAmount = amount
        self.transactions = transactions
        self.currency = currency
    }
    public mutating func addTransaction(_ amount: Decimal, date: Date? = nil) throws {
        guard amount != 0 else {  throw TransactionError.invalidAmount(amount) }
        let newTransaction = Transaction(date: date ?? .now, amount: amount, category: .income(.ponctuel))
        transactions.append(newTransaction)
    }
    
    public mutating func addCashWithdrawal(_ amount: Decimal, date: Date? = nil) throws {
        guard amount != 0 else { throw TransactionError.invalidAmount(amount) }
        guard amountSaved - amount >= 0 else { throw TransactionError.insufficientFunds}
        let newTransaction = Transaction(date: date ?? .now, amount: -amount, category: .expense(.other))
        transactions.append(newTransaction)
        
    }
    
    public mutating func updateName(_ name: String) {
        guard !name.isEmpty, name != self.name else { return }
        self.name = name
    }
    public mutating func updateDate(_ date: Date) {
        guard date != self.deadline else { return }
        self.deadline = date
    }
    
    public func feasibilityCalculation(_ availableSavingsCapacity: Decimal) -> FeasibilityAnswer {
        FeasibilityAnswer.positiveAnswer
    }
}
