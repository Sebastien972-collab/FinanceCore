//
//  ProjectData.swift
//  FinanceCore
//
//  Created by Sébastien DAGUIN on 23/10/2025.
//

import Foundation

/// Modèle représentant un projet côté client (correspond à ton API Vapor)
public struct ProjectData: Codable, Identifiable, Sendable {
    public let id: UUID
    public let name: String
    public let iconName: String
    public let creationDate: Date?
    public let endDate: Date
    public let amountSaved: Double
    public let amountTotal: Double
    public let userID: UUID

    // Initialiseur public explicite
    public init(
        id: UUID,
        name: String,
        iconName: String,
        creationDate: Date? = nil,
        endDate: Date,
        amountSaved: Double,
        amountTotal: Double,
        userID: UUID
    ) {
        self.id = id
        self.name = name
        self.iconName = iconName
        self.creationDate = creationDate
        self.endDate = endDate
        self.amountSaved = amountSaved
        self.amountTotal = amountTotal
        self.userID = userID
    }
}
