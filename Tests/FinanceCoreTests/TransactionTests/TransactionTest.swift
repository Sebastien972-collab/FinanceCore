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
        var transaction = Transaction(date: .now, amount: 12.99, currency: .eur, category: .expense(.subscriptions))
        do {
            try transaction.updateNote(with: "Netflix")
        } catch  {
            #expect(Bool(false), "Une erreur a été levée : \(error.localizedDescription)")
        }
    }
    
    @Test("Vérification d'une format de la transaction nombre positif")
    func addIncomeFormated() async throws {
        let transaction = Transaction(date: .now, amount: 12.99, currency: .eur, category: .income(.investment))
        #expect(transaction.formattedAmount == "12,99€")
    }
    
    @Test("Vérification d'une format de la transaction nombre négatif")
    func addExpenseFormated() async throws {
        let transaction = Transaction(date: .now, amount: -12.99, currency: .eur, category: .expense(.subscriptions))
        #expect(transaction.formattedAmount == "-12,99€")
    }
    
    @Test("Mise à jour du label")
    func updateLabel() async throws {
        var transaction = Transaction(date: .now, amount: 10, currency: .eur, category: .income(.salary))
        transaction.updateLabel(with: "Salaire Août")
        #expect(transaction.label == "Salaire Août")
        transaction.updateLabel(with: "Salaire Septembre")
        #expect(transaction.label == "Salaire Septembre")
    }

    @Test("Vérification de l'identifiant unique")
    func uniqueID() async throws {
        let t1 = Transaction(date: .now, amount: 1, currency: .eur, category: .income(.salary))
        let t2 = Transaction(date: .now, amount: 1, currency: .eur, category: .income(.salary))
        #expect(t1.id != t2.id)
    }

    @Test("Erreur lors de la mise à jour d'une note identique")
    func updateNoteThrows() async throws {
        var transaction = Transaction(date: .now, amount: 5, currency: .eur, category: .expense(.subscriptions), recurrence: .none, note: "Netflix")
        var didThrow = false
        do {
            try transaction.updateNote(with: "Netflix")
        } catch {
            didThrow = true
        }
        #expect(didThrow, "La fonction doit lancer une erreur si la note existe déjà.")
    }

    @Test("isIncome fonctionne pour revenu et dépense")
    func isIncomeFlag() async throws {
        let income = Transaction(date: .now, amount: 100, currency: .eur, category: .income(.salary))
        let expense = Transaction(date: .now, amount: -50, currency: .eur, category: .expense(.subscriptions))
        #expect(income.isIncome)
        #expect(!expense.isIncome)
    }

    @Test("Update recurrence")
    func updateRecurrence() async throws {
        var transaction = Transaction(date: .now, amount: 20, currency: .eur, category: .expense(.subscriptions))
        transaction.updateRecurrence(with: .monthly)
        #expect(transaction.recurrence == .monthly)
    }
    
}
