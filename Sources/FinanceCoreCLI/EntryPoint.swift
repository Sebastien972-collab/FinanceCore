//
//  File.swift
//  FinanceCore
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

        // Ici, appelle des fonctions de ta LIB FinanceCore
        print("CLI prêt. Branche ta logique FinanceCore ici.")
    }
}
