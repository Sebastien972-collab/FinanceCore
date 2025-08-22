//
//  Test.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 22/08/2025.
//
import Testing
import FinanceCore
import Foundation


struct ToolBox {
    private let calculator = FinanceCalculator()
    @Test("Calcul amount 20 percent of 250  ")
    func calculPercentOf250() async throws {
        #expect(calculator.percentage(of: 250, percent: 20) == 50)
    }
    @Test("Calcul amount 50 percent of 100 ")
    func calculPercentOf100() {
        #expect(calculator.percentage(of: 100, percent: 50) == 50)
    }
    @Test("Calcul amount 0 percent of 100 ")
    func calculPercentOfZero() {
        #expect(calculator.percentage(of: 100, percent: 0) == 0)
    }
    @Test("Calculates the value after subtracting a percentage.20 percent of 250 ")
    func calculMinus20Of250() async throws {
        #expect(calculator.minusPercentage(of: 250, percent: 20) == 200)
    }
}
