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
    var pictureData: Data?
    var birthday: Date?

    var isNotificationEnabled: Bool = true
    var notificationTime: Time

    init(id: UUID = UUID(), name: String, email: String, pictureData: Data? = nil, birthday: Date? = nil, isNotificationEnabled: Bool = false, notificationTime: Time = .init(hour: 19, minute: 0)) {
        self.id = id
        self.name = name
        self.email = email
        self.pictureData = pictureData
        self.birthday = birthday
        self.isNotificationEnabled = isNotificationEnabled
        self.notificationTime = notificationTime
    }
}
