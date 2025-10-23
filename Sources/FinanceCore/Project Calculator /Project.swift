//
//  Project.swift
//  FinanceCore
//
//  Created by Sébastien Daguin on 29/09/2025.
//

import Foundation

public class Project: Identifiable, Equatable, Hashable {
    public var id: UUID
    public var name: String
    public var iconName: String
    public var creationDate: Date?
    public var endDate: Date
    public var amountSaved: Double
    public var amountTotal: Double
    public var userID: UUID
    
    public init(
        id: UUID = UUID(),
        name: String,
        iconName: String,
        creationDate: Date? = .now,
        endDate: Date,
        amountSaved: Double = 0.0,
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
    
    // MARK: - Conversion depuis ProjectData
    public convenience init(from data: ProjectData) {
        self.init(
            id: data.id,
            name: data.name,
            iconName: data.iconName,
            creationDate: data.creationDate,
            endDate: data.endDate,
            amountSaved: data.amountSaved,
            amountTotal: data.amountTotal,
            userID: data.userID
        )
    }
    
    // MARK: - Conversion inverse
    public func toData() -> ProjectData {
        ProjectData(
            id: id,
            name: name,
            iconName: iconName,
            creationDate: creationDate,
            endDate: endDate,
            amountSaved: amountSaved,
            amountTotal: amountTotal,
            userID: userID
        )
    }
    
    // MARK: - Hashable / Equatable
    public static func == (lhs: Project, rhs: Project) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
