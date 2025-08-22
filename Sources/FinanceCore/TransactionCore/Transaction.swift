//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 21/08/2025.
//

import Foundation

public struct Transaction {
    public let id: UUID = .init()
    public let date: Date
    public let amount: Decimal
    public let currency: String
    public let category: TransactionCategory
    public let recurrence: RecurrenceFrequency?
    public private(set) var note: String?
    public var isIncome: Bool { if case .income = category { return true } else { return false } }
    
    public init(date: Date, amount: Decimal, currency: String, category: TransactionCategory, note: String?, recurrence: RecurrenceFrequency?) {
        self.date = date
        self.amount = amount
        self.currency = currency
        self.category = category
        self.note = note
        self.recurrence = recurrence
    }
    
    /// This function allows you to update the text note and returns an error if it is not accepted
    public mutating func updateNote(_ text: String) throws {
        guard note != text else { throw TransactionError.noteExist }
        self.note = text
    }
    
    
}
