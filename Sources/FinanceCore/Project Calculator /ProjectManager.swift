//
//  File.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 29/09/2025.
//

import Foundation

@Observable
open class ProjectManager {
    public var projects: [Project] = []
    public var error: Error = TransactionError.unknown
    
    public func fetch() {
    }
    
    func add(_ project: Project) {
        
    }
}
