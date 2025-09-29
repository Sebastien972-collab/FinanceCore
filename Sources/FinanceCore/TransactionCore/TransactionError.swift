//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 22/08/2025.
//

import Foundation

public enum TransactionError: Error, LocalizedError, Sendable {
    case invalidAmount(Decimal)
    case missingCategory
    case dateNotAllowed
    case noteNotAllowed
    case noteExist
    case insufficientFunds
    case unknown
    
    /// Message par défaut pour LocalizedError
    public var errorDescription: String? {
        switch self {
        case .invalidAmount(let amount):
            return "Le montant: \(amount) est invalide."
        case .missingCategory:
            return "Aucune catégorie n'a été choisie."
        case .dateNotAllowed:
            return "La date choisie n'est pas valide."
        case .unknown:
            return "Une erreur inattendue s'est produite."
        case .noteNotAllowed:
            return "Cette note n'est pas valide"
        case .noteExist:
            return "Cette note existe déjà"
        case .insufficientFunds:
            return "Fonds insuffisants."
        }
    }
}
