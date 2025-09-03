//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 22/08/2025.
//

import Foundation

public enum CurrencyAvailable: String, Hashable, CaseIterable, Sendable {
    case usd = "USD"
    case eur = "EUR"
    case jpy = "JPY"
    case gbp = "GBP"
    case aud = "AUD"
    case cad = "CAD"
    case chf = "CHF"
    case cny = "CNY"
    
    /// Full name readable by a user
    public var completeName: String {
        switch self {
        case .usd: return "Dollar américain"
        case .eur: return "Euro"
        case .jpy: return "Yen japonais"
        case .gbp: return "Livre sterling"
        case .aud: return "Dollar australien"
        case .cad: return "Dollar canadien"
        case .chf: return "Franc suisse"
        case .cny: return "Yuan chinois (Renminbi)"
        }
    }
    
    /// Associated monetary symbol
    public var symbol: String {
        switch self {
        case .usd, .cad, .aud: return "$"
        case .eur: return "€"
        case .jpy, .cny: return "¥"
        case .gbp: return "£"
        case .chf: return "CHF"
        }
    }
}
