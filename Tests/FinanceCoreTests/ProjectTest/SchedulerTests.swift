//
//  Test.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 30/09/2025.
//

import Testing
import Foundation
import FinanceCore

@Suite("Tests du Scheduler")
struct SchedulerTests {
    
    @Test("Le scheduler doit créer le bon nombre de steps")
    func testNumberOfSteps() async throws {
        let scheduler = Scheduler(starDate: .now, monthlyAmount: 200, totalMonths: 6)
        #expect(scheduler.steps.count == 6)
    }
    
    @Test("Les dates doivent s’incrémenter de 1 mois")
    func testMonthlyIncrement() async throws {
        let startDate = Date()
        let scheduler = Scheduler(starDate: startDate, monthlyAmount: 100, totalMonths: 3)
        let calendar = Calendar.current
        
        for (index, step) in scheduler.steps.enumerated() {
            let expectedDate = calendar.date(byAdding: .month, value: index, to: startDate)
            #expect(calendar.component(.month, from: step.date) == calendar.component(.month, from: expectedDate!))
        }
    }
    
    @Test("Chaque step doit contenir le montant mensuel")
    func testExpectedAmountConsistency() async throws {
        let scheduler = Scheduler(starDate: .now, monthlyAmount: 150, totalMonths: 4)
        for step in scheduler.steps {
            #expect(step.expectedAmount == 150)
        }
    }
    
    @Test("La somme totale doit être correcte")
    func testTotalAmount() async throws {
        let monthly: Decimal = 250
        let months = 5
        let scheduler = Scheduler(starDate: .now, monthlyAmount: monthly, totalMonths: months)
        
        let total = scheduler.steps.reduce(Decimal(0)) { $0 + $1.expectedAmount }
        #expect(total == monthly * Decimal(months))
    }
    
    @Test("Init avec steps personnalisés doit les conserver")
    func testInitWithCustomSteps() async throws {
        let steps = [
            SchedulerStep(date: .now, expectedAmount: 300),
            SchedulerStep(date: Calendar.current.date(byAdding: .month, value: 1, to: .now)!, expectedAmount: 300)
        ]
        
        let scheduler = Scheduler(starDate: .now, monthlyAmount: 300, totalMonths: 2, steps: steps)
        
        #expect(scheduler.steps.count == 2)
        #expect(scheduler.steps[0].expectedAmount == 300)
    }
}
