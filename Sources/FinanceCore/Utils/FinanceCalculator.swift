//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 22/08/2025.
//

import Foundation

/// Utilitaire pour effectuer des calculs financiers basés sur des pourcentages et des fractions.
public struct FinanceCalculator: Sendable {

    public init() {}

    /// Calcule `percent` % d’une valeur donnée.
    /// - Parameters:
    ///   - value: montant de base
    ///   - percent: pourcentage (ex: 10 pour 10%)
    /// - Returns: le montant correspondant
    public func percentage(of value: Decimal, percent: Decimal) -> Decimal {
         value * percent / 100
    }

    /// Calcule la valeur après soustraction d’un pourcentage.
    /// - Example: 100 - 10% = 90
    public func minusPercentage(of value: Decimal, percent: Decimal) -> Decimal {
         value - percentage(of: value, percent: percent)
    }

    /// Calcule une fraction (numérateur / dénominateur) d’une valeur.
    /// - Example: quart (3/4 de 800) = 600
    public func fraction(of value: Decimal, numerator: Decimal, denominator: Decimal) -> Decimal {
        guard denominator != 0 else { return 0 }
        return value * numerator / denominator
    }

    /// Raccourcis utiles
    public func half(of value: Decimal) -> Decimal {
         fraction(of: value, numerator: 1, denominator: 2)
    }

    public func quarter(of value: Decimal) -> Decimal {
         fraction(of: value, numerator: 1, denominator: 4)
    }

    public func threeQuarter(of value: Decimal) -> Decimal {
         fraction(of: value, numerator: 3, denominator: 4)
    }
}
