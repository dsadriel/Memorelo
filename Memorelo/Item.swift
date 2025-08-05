//
//  Item.swift
//  Memorelo
//
//  Created by Adriel de Souza on 05/08/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
