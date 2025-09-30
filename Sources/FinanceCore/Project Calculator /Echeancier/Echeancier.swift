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
    public var totalMonths: Int
    public var steps: [SchedulerStep] = []
    
    init(starDate: Date, monthlyAmount: Decimal, totalMonths: Int) {
        self.starDate = starDate
        self.monthlyAmount = monthlyAmount
        self.totalMonths = totalMonths
        createScheduler()
    }
    init(starDate: Date, monthlyAmount: Decimal, totalMonths: Int, steps: [SchedulerStep]) {
        self.starDate = starDate
        self.monthlyAmount = monthlyAmount
        self.totalMonths = totalMonths
        self.steps = steps
    }
    
    private mutating func createScheduler() {
        let calendar = Calendar.current
        for index in 0..<totalMonths {
            if let newDate = calendar.date(byAdding: .month, value: index, to: starDate) {
                let step = SchedulerStep(date: newDate, expectedAmount: monthlyAmount)
                self.steps.append(step)
            }
            
        }
    }
}
