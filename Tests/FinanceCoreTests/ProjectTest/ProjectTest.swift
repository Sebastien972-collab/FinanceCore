//
//  Test.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 29/09/2025.
//

import Testing
import Foundation
import FinanceCore

@Suite("Test de la structure projet")
struct ProjectTest {
    @Test("Add a transaction in projetc")
    func addTransaction() async throws {
        var newProject = Project(name: "Test Project", finalDate: Date(), amount: 100.00)
        try newProject.addTransaction(100.00)
        #expect(newProject.transactions.count == 1)
        #expect(newProject.amountSaved == 100.0)
        
    }
    @Test("Add a transaction Cash Withdrawal")
    func addCashWithdrawal() async throws {
        var newProject = Project(name: "Test Project", finalDate: Date(), amount: 100.00)
        try newProject.addTransaction(100.00)
        try newProject.addCashWithdrawal(100.00)
        #expect(newProject.transactions.count == 2)
        #expect(newProject.amountSaved == 0)
        
    }
    @Test("Add a transaction and show the amount formatted")
    func testFormattedAmound() async throws {
        var newProject = Project(name: "Test Project", finalDate: Date(), amount: 100.00)
        try newProject.addTransaction(100.00)
        try newProject.addTransaction(100.00)
        try newProject.addTransaction(100.50)
        #expect(newProject.transactions.count == 3)
        #expect(newProject.amountSaved == 300.50)
        #expect(newProject.formattedAmount == "300,50€")
        
    }
}
