//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 22/08/2025.
//

import Foundation

@Observable
class FinancialProfileManager {
    var revenues: Decimal = 0.00
    private(set) var expenses: Decimal = 0.00
    private(set) var transactions: [Transaction] = []
    private var calculator = FinanceCalculator()
    var precautionarySavings: Decimal {
        expenses * 3
    }
    private(set) var ras: Decimal = 0.0
    private(set) var availableForSaving: Decimal = 0.0
    private(set) var microSaving: Decimal = 0.0
    
    public init(revenues: Decimal, expenses: Decimal) {
        self.revenues = revenues
        self.expenses = expenses
    }
    
    public init(revenues: Decimal, transactions: [Transaction]) {
        self.revenues = revenues
        self.transactions = transactions
        
    }
    
    func calculateWith(_ exprense: Decimal) -> FinancialProfile {
        guard revenues > 0 else { return .none }
        let rest = revenues - exprense
        guard rest > 0 else { return .none }
        availableForSaving = calculator.quarter(of: rest)
        let restAfterSaving = rest - availableForSaving
        microSaving = calculator.minusPercentage(of: restAfterSaving, percent: 10)
        ras = restAfterSaving - microSaving
        
        
        
        
        
        
        
        
    }
    
    
    
}
