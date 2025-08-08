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
    var relation: String
    var birthday: Date
    var pictureData: Data?
    var isArchived: Bool = false

    var ageString: String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: birthday, to: Date())

        if let years = components.year, let months = components.month, years + months != 0 {
            return "\((years != 0) ? "\(years) anos" : "") \(months != 0 ? "\(months) meses" : "")"
        }

        return "Menos de 1 mês"
    }

    init(id: UUID = UUID(), name: String, relation: String, birthday: Date, pictureData: Data? = nil) {
        self.id = id
        self.name = name
        self.relation = relation
        self.birthday = birthday
        self.pictureData = pictureData
    }
}
