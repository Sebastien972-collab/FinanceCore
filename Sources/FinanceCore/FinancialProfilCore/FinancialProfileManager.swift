//
//  FinancialProfileManager.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 22/08/2025.
//

import Foundation

/// Gère les calculs financiers d’un profil utilisateur à partir de ses revenus et dépenses.
/// Calcule la répartition de l’épargne, la capacité d’épargne et le profil financier associé.
public final class FinancialProfileManager {
    public private(set) var revenues: Decimal = 0
    public private(set) var expenses: Decimal = 0
    public private(set) var transactions: [Transaction] = []
    private let calculator = FinanceCalculator()
    
    // MARK: - Indicateurs principaux
    /// Capacité d’épargne disponible = revenus - dépenses
    public var availableSavingsCapacity: Decimal = 0
    
    /// Base de sécurité (3/4 du reste après dépenses)
    public private(set) var safetyBase: Decimal = 0
    
    /// Épargne de prévoyance
    public private(set) var savingProvide: Decimal = 0
    
    /// Micro-épargne de sécurité mensuelle
    public private(set) var amountSavedForSecurity: Decimal = 0
    
    /// Épargne long terme
    public private(set) var longTermSavings: Decimal = 0
    
    /// Tampon de sécurité (10% de safetyBase)
    public private(set) var bufferAmount: Decimal = 0
    
    /// Reste à servir (revenus après épargne et dépenses)
    public private(set) var ras: Decimal = 0
    
    /// Épargne projet (1/4 du RAS si souhaité)
    public private(set) var availableForSaving: Decimal = 0
    
    // Épargne de précaution cible (3 × dépenses)
    public var precautionarySavingsAmount: Decimal { expenses * 3 }
    
    // Profil financier calculé à partir du RAS
    public var profile: FinancialProfile {
        FinancialProfile.classify(with: ras)
    }
    
    // MARK: - Initialisation
    public init(revenues: Decimal, expenses: Decimal) {
        self.revenues = revenues
        self.expenses = expenses
        self.availableSavingsCapacity = revenues - expenses
    }

    public init(revenues: Decimal, transactions: [Transaction]) {
        self.revenues = revenues
        self.transactions = transactions
        self.expenses = transactions.reduce(Decimal(0)) { $0 + $1.amount }
        self.availableSavingsCapacity = revenues - expenses
    }
    
    // MARK: - Calcul de la répartition selon le profil
    public func calculateSavingDistribution() {
        switch profile {
        case .survivor:
            distribution(asfsPercent: 55, savingsProvidePercent: 10)
        case .equilibrist:
            distribution(asfsPercent: 50, savingsProvidePercent: 10, longTermSavingPercent: 10)
        case .builder:
            distribution(asfsPercent: 45, savingsProvidePercent: 15, longTermSavingPercent: 10)
        case .strategist:
            distribution(asfsPercent: 40, savingsProvidePercent: 10, longTermSavingPercent: 15)
        case .none:
            break
        }
    }
    
    // MARK: - Méthode de distribution des pourcentages
    private func distribution(asfsPercent: Decimal,
                              savingsProvidePercent: Decimal,
                              longTermSavingPercent: Decimal? = nil) {
        guard availableSavingsCapacity > 0 else { return }
        
        // 1. Épargne de sécurité
        amountSavedForSecurity = calculator.percentage(of: availableSavingsCapacity, percent: asfsPercent)
        let remainingAfterSecurity = availableSavingsCapacity - amountSavedForSecurity
        guard remainingAfterSecurity > 0 else { return }
        
        // 2. Épargne de prévoyance
        savingProvide = calculator.percentage(of: remainingAfterSecurity, percent: savingsProvidePercent)
        let remainingAfterSavingProvide = remainingAfterSecurity - savingProvide
        
        // 3. Épargne long terme (si applicable)
        if let longTermSavingPercent {
            longTermSavings = calculator.percentage(of: remainingAfterSavingProvide, percent: longTermSavingPercent)
            ras = remainingAfterSavingProvide - longTermSavings
        } else {
            ras = remainingAfterSavingProvide
        }
        
        // 4. Épargne projet (optionnelle : 1/4 du RAS)
        availableForSaving = calculator.quarter(of: ras)
    }
}
