//
//  MemberProfile.swift
//  Memorelo
//
//  Created by Adriel de Souza on 07/08/25.
//

import SwiftData
import Foundation

@Model
final class MemberProfile: Identifiable {
    var id: UUID
    var name: String
    var firstName: String {
        let dividerIndex = name.firstIndex(of: " ") ?? name.endIndex
        return String(name[..<dividerIndex])
    }
    var relation: String
    var birthday: Date
    var pictureData: Data?
    var isArchived: Bool = false

    init(id: UUID = UUID(), name: String, relation: String, birthday: Date, pictureData: Data? = nil) {
        self.id = id
        self.name = name
        self.relation = relation
        self.birthday = birthday
        self.pictureData = pictureData
    }
}
