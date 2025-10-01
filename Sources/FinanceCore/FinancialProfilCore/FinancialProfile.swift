//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 22/08/2025.
//

import Foundation

public enum FinancialProfile: String, CaseIterable, Codable, Hashable, Sendable {
    case survivor = "Survivant"
    case equilibrist = "Equilibriste"
    case builder = "Batisseur"
    case strategist = "Stratège"
    case none = "Aucun profile"
    
    ///It is the threshold for each financial profile
    public var ascUpperBound: Decimal? {
        switch self {
        case .survivor:
            return 150
        case .equilibrist:
            return 250
        case .builder:
            return 500
        case .strategist:
            return nil
        case .none:
            return nil
        }
    }
    ///Classifies the profile from a monthly ASC.
    public static func classify(with asc: Decimal) -> FinancialProfile {
        if asc <= survivor.ascUpperBound ?? 150 { return .survivor }
        if asc <= equilibrist.ascUpperBound ?? 250 { return .equilibrist }
        if asc <= builder.ascUpperBound ?? 500 { return .builder }
        return .strategist
    }
}
