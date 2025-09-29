//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 21/08/2025.
//

import Foundation

public enum ExpenseType: String, Hashable, CaseIterable, Sendable {
    case fixed = "Dépense fixe"
    case rent = "Loyer"
    case utilities = "Factures"
    case groceries = "Courses"
    case transport = "Transport"
    case leisure = "Loisirs"
    case subscriptions = "Abonnements"
    case other = "Autres"
    
}
