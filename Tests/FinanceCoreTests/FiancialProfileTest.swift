//
//  Test.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 22/08/2025.
//

import Testing
import Foundation
import FinanceCore

struct Test {
    @Test func pfRasMax() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let pf = FinancialProfile.builder
        #expect(pf.rasUpperBound == 800)
    }
    @Test("Étant donner un profil survivant ")
    func pSurvivoirfRasMax() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let pf = FinancialProfile.survivor
        #expect(pf.rasUpperBound == 150)
    }
    @Test("Test Étant donner un RAS de 150 doit donner un survivant")
    func chexkRasSurvivor() async throws {
        let ras: Decimal = 150
        #expect(FinancialProfile.survivor == FinancialProfile.classify(with: ras))
    }
    @Test("Etant donner un RAS de 250")
    func chesckRasEquilibrist() async throws {
        let ras: Decimal = 250
        #expect(FinancialProfile.classify(with: ras) == FinancialProfile.equilibrist)
    }

}
