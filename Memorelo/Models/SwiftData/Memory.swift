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
    var attachments: [MemoryAttachment]
    var tags: [String]
    var location: String?
    var details: String?
    var participants: [MemberProfile]

    init(id: UUID = UUID(), title: String, date: Date, attachments: [MemoryAttachment], tags: [String], location: String? = nil, details: String? = nil, participants: [MemberProfile]) {
        self.id = id
        self.title = title
        self.date = date
        self.attachments = attachments
        self.tags = tags
        self.location = location?.isEmpty ?? true ? nil : location
        self.details = details?.isEmpty ?? true ? nil : details
        self.participants = participants
    }
}
