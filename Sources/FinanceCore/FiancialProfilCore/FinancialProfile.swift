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
    public var rasUpperBound: Decimal? {
        switch self {
        case .survivor:
            return 150
        case .equilibrist:
            return 400
        case .builder:
            return 800
        case .strategist:
            return nil
        case .none:
            return nil
        }
    }
    ///Classifies the profile from a monthly RAS.
    public static func classify(with ras: Decimal) -> FinancialProfile {
        if ras < survivor.rasUpperBound ?? 150 { return .survivor }
        if ras < equilibrist.rasUpperBound ?? 400 { return .equilibrist }
        if ras < builder.rasUpperBound ?? 800 { return .builder }
        return .strategist
    }
}
