//
//  UserProfile.swift
//  Memorelo
//
//  Created by Adriel de Souza on 07/08/25.
//

import SwiftData
import Foundation

@Model
final class UserProfile: Identifiable {
    var id: UUID
    var name: String
    var email: String
    var picture: URL?
    var birthday: Date?

    var isNotificationEnabled: Bool = true
    var notificationTime: Time

    init(id: UUID, name: String, email: String, picture: URL? = nil, birthday: Date? = nil, isNotificationEnabled: Bool, notificationTime: Time) {
        self.id = id
        self.name = name
        self.email = email
        self.picture = picture
        self.birthday = birthday
        self.isNotificationEnabled = isNotificationEnabled
        self.notificationTime = notificationTime
    }
}
