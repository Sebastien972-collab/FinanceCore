//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 30/09/2025.
//

import Foundation

public struct Scheduler {
    public var starDate: Date
    public var monthlyAmount: Decimal
    public var finalDate: Date
    public var totalMonths: Int
    public var steps: [SchedulerStep] = []
    
    public init(starDate: Date, monthlyAmount: Decimal, totalMonths: Int) {
        self.starDate = starDate
        self.monthlyAmount = monthlyAmount
        self.totalMonths = totalMonths
        self.finalDate = Calendar.current.date(byAdding: .month, value: max(totalMonths - 1, 0), to: starDate) ?? starDate
        createScheduler()
    }
    public init(starDate: Date, monthlyAmount: Decimal, totalMonths: Int, steps: [SchedulerStep]) {
        self.starDate = starDate
        self.monthlyAmount = monthlyAmount
        self.totalMonths = totalMonths
        self.steps = steps
        self.finalDate = Calendar.current.date(byAdding: .month, value: max(totalMonths - 1, 0), to: starDate) ?? starDate
    }
    
    private mutating func createScheduler() {
        let calendar = Calendar.current
        self.steps.removeAll(keepingCapacity: true)
        for index in 0..<max(totalMonths, 0) {
            if let newDate = calendar.date(byAdding: .month, value: index, to: starDate) {
                let step = SchedulerStep(date: newDate, expectedAmount: monthlyAmount)
                self.steps.append(step)
            }
        }
    }
}

