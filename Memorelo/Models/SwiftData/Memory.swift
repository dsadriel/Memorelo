//
//  Memory.swift
//  Memorelo
//
//  Created by Adriel de Souza on 07/08/25.
//

import SwiftData
import Foundation

@Model
final class Memory: Identifiable {
    var id: UUID
    var title: String
    var date: Date
    var attachementsIds: [UUID]
    var tags: [String]
    var location: String?
    var details: String?
    var participants: [UUID]

    init(id: UUID, title: String, date: Date, attachementsIds: [UUID], tags: [String], location: String? = nil, details: String? = nil, participants: [UUID]) {
        self.id = id
        self.title = title
        self.date = date
        self.attachementsIds = attachementsIds
        self.tags = tags
        self.location = location
        self.details = details
        self.participants = participants
    }
}
