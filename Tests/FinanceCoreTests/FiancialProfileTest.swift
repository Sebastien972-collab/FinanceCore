import Testing
import Foundation
import FinanceCore

@Suite("Tests unitaires du profil financier")
struct FinancialProfileTests {
    @Test("rasUpperBound: valeurs attendues pour chaque profil")
    func rasUpperBoundValues() async throws {
        #expect(FinancialProfile.survivor.ascUpperBound == 150)
        #expect(FinancialProfile.equilibrist.ascUpperBound == 250)
        #expect(FinancialProfile.builder.ascUpperBound == 500)
        #expect(FinancialProfile.strategist.ascUpperBound == nil)
        #expect(FinancialProfile.none.ascUpperBound == nil)
    }
    
    @Test("classify: RAS à la frontière du survivant")
    func classifySurvivorBound() async throws {
        #expect(FinancialProfile.classify(with: 0) == .survivor)
        #expect(FinancialProfile.classify(with: 150) == .survivor)
    }
    
    @Test("classify: RAS juste après la frontière du survivant")
    func classifyEquilibristMin() async throws {
        #expect(FinancialProfile.classify(with: 151) == .equilibrist)
        #expect(FinancialProfile.classify(with: 400) == .builder)
    }
    
    @Test("classify: RAS juste après la frontière de l'équilibrist")
    func classifyBuilderMin() async throws {
        #expect(FinancialProfile.classify(with: 401) == .builder)
        #expect(FinancialProfile.classify(with: 800) == .strategist)
    }
    
    @Test("classify: RAS au‑dessus du builder, strategist")
    func classifyStrategist() async throws {
        #expect(FinancialProfile.classify(with: 801) == .strategist)
        #expect(FinancialProfile.classify(with: 10000) == .strategist)
    }
    
    @Test("classify: valeurs extrêmes et inattendues")
    func classifyExtremeValues() async throws {
        #expect(FinancialProfile.classify(with: -50) == .survivor) // négatif = survivor
        #expect(FinancialProfile.classify(with: Decimal.greatestFiniteMagnitude) == .strategist)
    }
}
