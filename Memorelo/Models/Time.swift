//
//  Time.swift
//  Memorelo
//
//  Created by Adriel de Souza on 07/08/25.
//

struct Time: Codable {
    var hour: Int
    var minute: Int
    var second: Int
    
    init(hour: Int = 0, minute: Int = 0, second: Int = 0) {
        self.hour = hour
        self.minute = minute
        self.second = second
    }
}
