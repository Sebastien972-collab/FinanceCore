import Foundation

public final class FinancialProfileManager {
    public var revenues: Decimal = 0
    public private(set) var expenses: Decimal = 0
    public private(set) var transactions: [Transaction] = []

    private let calculator = FinanceCalculator()

    // Indicateurs
    ///Correspond à la capacité d'épargne disponible (ced)
    public private(set) var availableSavingsCapacity: Decimal = 0       // revenus - dépenses
    /// Le reste de ses revenues en enlevant son épargne de sécurité
    public private(set) var safetyBase: Decimal = 0 // 3/4 de baseAfterExpenses
    ///Montant de sa micro épargne du moos
    public private(set) var amountSavedForSecurity: Decimal = 0
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
    }

    public init(revenues: Decimal, transactions: [Transaction]) {
        self.revenues = revenues
        self.transactions = transactions
        // tu pourrais dériver `expenses` depuis transactions si besoin
    }

    /// Calcule le profil à partir d'un montant de dépenses (expenses) fourni.
    @discardableResult
    public func calculateWithExpense() -> FinancialProfile {
        guard revenues > 0 else { return .survivor }

        // 1) Solde après dépenses fixes
        availableSavingsCapacity = revenues - expenses
        guard availableSavingsCapacity > 0 else {
            ras = 0
            return .survivor
        }

        // 2) Réserve sécurité : garder 3/4
        safetyBase = calculator.threeQuarter(of: availableSavingsCapacity)
        amountSavedForSecurity = availableSavingsCapacity - safetyBase

        // 3) Marge prudence : 10% de la safetyBase
        bufferAmount = calculator.percentage(of: safetyBase, percent: 10)

        // 4) RAS final
        ras = safetyBase - bufferAmount

        // 5) (Option) proposer d’épargner 1/4 du RAS pour un projet
        projectSavingQuarter = calculator.quarter(of: ras)

        return FinancialProfile.classify(with: ras)
    }
}
