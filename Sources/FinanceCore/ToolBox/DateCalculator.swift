//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien DAGUIN on 01/10/2025.
//

import Foundation


public struct DateCalculator {
    public init(){}
    public static func monthsBetween(_ startDate: Date, _ endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: startDate, to: endDate)
        return components.month ?? 0
    }

    
}
