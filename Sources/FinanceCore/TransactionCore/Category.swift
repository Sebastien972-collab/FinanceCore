//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 21/08/2025.
//

import Foundation

public enum TransactionCategory: Hashable {
    case income(IncomeType)
    case expense(ExpenseType)
    
    public var label: String {
        switch self {
        case .income:
            return "Revenues"
        case .expense:
            return "Dépenses"
        }
    }
    
}
