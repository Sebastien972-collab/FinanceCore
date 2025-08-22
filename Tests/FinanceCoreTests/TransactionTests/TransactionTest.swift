//
//  Test.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 22/08/2025.
//

import Testing
import FinanceCore
import Foundation

struct TransactionTest {
    @Test("Ajout d'une note dans transaction")
    func addNote() async throws {
        var transaction = Transaction(date: .now, amount: 12.99, currency: "EUR", category: .expense(.subscriptions), note: "Netflix", recurrence: .monthly)
        do {
            try transaction.updateNote("newNote")
            
        } catch  {
            #expect(Bool(false), "Une erreur a été levée : \(error.localizedDescription)")
        }
        
    }
}

