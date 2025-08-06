//
//  ActivitySuggestion.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import Foundation

struct ActivitySuggestion: Hashable {
    var title: String
    var description: String
    var goal: String
    var durationInMinutes: Int
    var suggestedAgeInMonths: Range<Int>

    var suggestedAgeInYears: Range<Int> {
        (suggestedAgeInMonths.lowerBound / 12)..<(suggestedAgeInMonths.upperBound / 12)
    }

    var durationString: String {
        let hours = durationInMinutes / 60
        let minutes = durationInMinutes % 60
        switch (hours, minutes) {
        case (0, let m):
            return "\(m) min"
        case (let h, 0):
            return "\(h)h"
        default:
            return "\(hours)h \(minutes)min"
        }
    }
}
