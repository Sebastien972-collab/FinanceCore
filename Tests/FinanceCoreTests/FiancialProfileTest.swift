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
    @Test("Initialisation avec revenus et dépenses")
    func initWithRevenuesAndExpenses() async throws {
        let manager = FinancialProfileManager(revenues: 2000, expenses: 1200)
        
        #expect(manager.revenues == 2000)
        #expect(manager.expenses == 1200)
        #expect(manager.availableSavingsCapacity == 800)
    }
    @Test("Distribution pour profil Survivor")
    func survivorDistribution() async throws {
        let manager = FinancialProfileManager(revenues: 2000, expenses: 1000)
        manager.calculateSavingDistribution()
        
        #expect(manager.amountSavedForSecurity > 0)
        #expect(manager.savingProvide > 0)
        #expect(manager.ras >= 0)
    }
    
    @Test("Distribution pour profil Equilibrist")
    func equilibristDistribution() async throws {
        let manager = FinancialProfileManager(revenues: 2500, expenses: 1000)
        manager.calculateSavingDistribution()
        
        #expect(manager.amountSavedForSecurity > 0)
        #expect(manager.savingProvide > 0)
        //#expect(manager.longTermSavings > 0)
        #expect(manager.ras >= 0)
    }
    
    @Test("Distribution pour profil Builder")
    func builderDistribution() async throws {
        let manager = FinancialProfileManager(revenues: 3000, expenses: 1000)
        manager.calculateSavingDistribution()
        
        #expect(manager.amountSavedForSecurity > 0)
        #expect(manager.savingProvide > 0)
        //#expect(manager.longTermSavings > 0)
        #expect(manager.ras >= 0)
    }
    
    @Test("Distribution pour profil Strategist")
    func strategistDistribution() async throws {
        let manager = FinancialProfileManager(revenues: 5000, expenses: 2000)
        manager.calculateSavingDistribution()
        
        #expect(manager.amountSavedForSecurity > 0)
        #expect(manager.savingProvide > 0)
       // #expect(manager.longTermSavings > 0)
        #expect(manager.ras >= 0)
    }
    
    @Test("Cas limite : revenus < dépenses")
    func negativeCapacity() async throws {
        let manager = FinancialProfileManager(revenues: 1000, expenses: 1500)
        manager.calculateSavingDistribution()
        
        #expect(manager.availableSavingsCapacity < 0)
        #expect(manager.amountSavedForSecurity == 0)
        #expect(manager.savingProvide == 0)
        #expect(manager.ras == 0)
    }
    
    @Test("Cas limite : revenus == dépenses")
    func zeroCapacity() async throws {
        let manager = FinancialProfileManager(revenues: 1000, expenses: 1000)
        manager.calculateSavingDistribution()
        
        #expect(manager.availableSavingsCapacity == 0)
        #expect(manager.amountSavedForSecurity == 0)
        #expect(manager.savingProvide == 0)
        #expect(manager.ras == 0)
    }
}
