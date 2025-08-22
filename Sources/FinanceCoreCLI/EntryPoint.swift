//
//  FinanceCoreCLI.swift
//  FinanceCoreCLI
//
//  Created by Sébastien Daguin on 21/08/2025.
//

import Foundation
import FinanceCore

@main
struct FinanceCoreCLI {
    static func main() {
        let args = Array(CommandLine.arguments.dropFirst())
        if args.contains("--help") || args.contains("-h") {
            print("""
            financecore-cli
            Usage:
              financecore-cli [options]

            Options:
              -h, --help     Affiche l'aide
              --version      Affiche la version
            """)
            return
        }
        if args.contains("--version") {
            print("financecore-cli v0.1.0")
            return
        }

        print("CLI prêt. Branche ta logique FinanceCore ici.\n")

        // --- Saisie utilisateur sécurisée ---
        print("Combien gagnez-vous (revenus mensuels en €) ? ", terminator: "")
        guard let rLine = readLine(strippingNewline: true),
              let revenues = Decimal(string: rLine.replacingOccurrences(of: ",", with: ".")) else {
            print("Entrée invalide pour les revenus."); return
        }

        print("Quel est le total de vos charges fixes mensuelles (en €) ? ", terminator: "")
        guard let eLine = readLine(strippingNewline: true),
              let expenses = Decimal(string: eLine.replacingOccurrences(of: ",", with: ".")) else {
            print("Entrée invalide pour les charges."); return
        }

        // --- Calcul RAS & profil ---
        let manager = FinancialProfileManager(revenues: revenues, expenses: expenses)
        let profile = manager.calculate(with: expenses)

        // Pour rester compatible avec ton libellé “mettre de côté” on ré‑utilise le 1/4 du RAS
        let availableForSaving = manager.projectSavingQuarter

        // --- Affichage ---
        print("""
        ---------------- Résultat ----------------
        Revenu: \(revenues) €, Charges: \(expenses) €

        Capacité après charges (revenus - charges) : \(manager.availableSavingsCapacity) €
        Épargne de précaution cible (≈ 3 × charges) : \(manager.precautionarySavingsAmount) €
        Montant "à mettre de côté" (1/4 du RAS)     : \(availableForSaving) €
        Micro‑épargne (buffer 10 %)                 : \(manager.bufferAmount) €
        Reste à s’amuser (RAS)                      : \(manager.ras) €

        Profil financier : \(profile.rawValue)
        -------------------------------------------
        """)
    }
}
