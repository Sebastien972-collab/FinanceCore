//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 21/08/2025.
//

import Foundation

public struct Transaction: Identifiable, Hashable {
    public private(set) var id: UUID = .init()
    public var label: String?
    public let date: Date
    public let amount: Decimal
    public let currency: CurrencyAvailable
    public let category: TransactionCategory
    public private(set) var recurrence: RecurrenceFrequency = .none
    public private(set) var note: String = ""
    public var formattedAmount: String {
        "\(amount) \(currency.symbol)"
    }
    public var isIncome: Bool { if case .income = category { return true } else { return false } }
    //MARK: - Inits
    public init(date: Date, amount: Decimal, currency: CurrencyAvailable = .eur, category: TransactionCategory) {
        self.date = date
        self.amount = amount
        self.currency = currency
        self.category = category
    }
    public init(date: Date, amount: Decimal, currency: CurrencyAvailable = .eur, category: TransactionCategory, recurrence: RecurrenceFrequency) {
        self.init(date: date, amount: amount, currency: currency, category: category)
        self.recurrence = recurrence
    }
    public init(date: Date, amount: Decimal, currency: CurrencyAvailable = .eur, category: TransactionCategory, recurrence: RecurrenceFrequency, note: String) {
        self.init(date: date, amount: amount, currency: currency, category: category)
        self.note = note
        self.recurrence = recurrence
    }
    public init(id: UUID, date: Date, amount: Decimal, currency: CurrencyAvailable = .eur, category: TransactionCategory, recurrence: RecurrenceFrequency) {
        self.init(date: date, amount: amount, currency: currency, category: category)
        self.id = id
        self.recurrence = recurrence
    }
    
    //MARK: - UpdateFunctions
    
    /// This function allows you to update the text note and returns an error if it is not accepted
    public mutating func updateNote(with text: String) throws {
        guard note != text else { throw TransactionError.noteExist }
        self.note = text
    }
    ///This function update the label of transaction if new Label not empty
    public mutating func updateLabel(with newLabel: String) {
        guard newLabel != label else { return }
        self.label = newLabel
    }
    public mutating func updateRecurrence(with newRecurrence: RecurrenceFrequency) {
        self.recurrence = newRecurrence
    }
    
}
