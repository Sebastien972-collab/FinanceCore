//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 21/08/2025.
//

import Foundation

public enum IncomeType: String, Hashable, CaseIterable {
    case salary = "Salaire"
    case bonus = "Bonus"
    case idependant = "Indépendant"
    case investment = "Investissement"
    case ponctuel = "Ponctuel"
    case other = "Autre"
}
