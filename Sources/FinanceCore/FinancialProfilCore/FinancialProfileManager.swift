import Foundation

public final class FinancialProfileManager {
    public private(set) var revenues: Decimal = 0
    public private(set) var expenses: Decimal = 0
    public private(set) var transactions: [Transaction] = []
    private let calculator = FinanceCalculator()
    // Indicateurs
    ///Correspond à la capacité d'épargne disponible (ced)
    public var availableSavingsCapacity: Decimal = 0    // revenus - dépenses
    /// Le reste de ses revenues en enlevant son épargne de sécurité
    public private(set) var safetyBase: Decimal = 0 // 3/4 de baseAfterExpenses
    public private(set) var savingProvide: Decimal = 0 // Épargne de prévoyance
    ///Montant de sa micro épargne du moos
    public private(set) var amountSavedForSecurity: Decimal = 0
    public private(set) var longTermSavings:  Decimal = 0
    public private(set) var bufferAmount: Decimal = 0            // 10% de safetyBase
    ///Montant libre restant après ses épargnes
    public private(set) var ras: Decimal = 0                     // safetyBase - bufferAmount
    ///Montant de son épargne projet
    public private(set) var projectSavingQuarter: Decimal = 0    // optionnel: 1/4 du RAS si tu veux proposer d’épargner

    public var precautionarySavingsAmount: Decimal { expenses * 3 }

    public var profile: FinancialProfile {
        FinancialProfile.classify(with: ras)
    }

    public init(revenues: Decimal, expenses: Decimal) {
        self.revenues = revenues
        self.expenses = expenses
        self.availableSavingsCapacity = revenues - expenses
    }

    public init(revenues: Decimal, transactions: [Transaction]) {
        self.revenues = revenues
        self.transactions = transactions
        self.expenses = transactions.reduce(Decimal(0)) { $0 + $1.amount }
        self.availableSavingsCapacity = revenues - expenses
        // tu pourrais dériver `expenses` depuis transactions si besoin
    }

    /// Calcule le profil à partir d'un montant de dépenses (expenses) fourni.
    public func calculateSavingDistribution() {
        switch profile {
        case .survivor:
            distribution(asfsPercent: 55, savingsProvidePercent: 10)
        case .equilibrist:
            distribution(asfsPercent: 50, savingsProvidePercent: 10, longTermeSavingPercent: 10)
        case .builder:
            distribution(asfsPercent: 45, savingsProvidePercent: 15, longTermeSavingPercent: 10)
        case .strategist:
            distribution(asfsPercent: 40, savingsProvidePercent: 10, longTermeSavingPercent: 15)
        case .none:
           break
        }
    }
    
    private func distribution(asfsPercent: Decimal, savingsProvidePercent: Decimal, longTermeSavingPercent: Decimal? = nil) {
        guard availableSavingsCapacity > 0 else { return }
        amountSavedForSecurity = calculator.minusPercentage(of: availableSavingsCapacity, percent: asfsPercent)
        let remainingAfterSecurity = availableSavingsCapacity - amountSavedForSecurity
        guard remainingAfterSecurity > 0 else { return }
        savingProvide = calculator.minusPercentage(of: remainingAfterSecurity, percent: savingsProvidePercent)
        let remainingAfterSavingProvide = remainingAfterSecurity - savingProvide
        guard let longTermeSavingPercent = longTermeSavingPercent, remainingAfterSavingProvide > 0 else { return ras = remainingAfterSavingProvide }
        self.longTermSavings = calculator.minusPercentage(of: remainingAfterSavingProvide, percent: longTermeSavingPercent)
        self.ras = remainingAfterSavingProvide - longTermeSavingPercent
        
    }

}
