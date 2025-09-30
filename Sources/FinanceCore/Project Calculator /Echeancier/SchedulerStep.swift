//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 30/09/2025.
//

import Foundation

public struct SchedulerStep: Identifiable, Codable {
    public private(set) var id = UUID()
    public var date: Date
    public var expectedAmount: Decimal
    public var passed: Bool = false
    
    public init(date: Date, expectedAmount: Decimal) {
        self.date = date
        self.expectedAmount = expectedAmount
    }
    public init(id: UUID, date: Date, expectedAmount: Decimal, passed: Bool) {
        self.id = id
        self.date = date
        self.expectedAmount = expectedAmount
        self.passed = passed
    }
}
