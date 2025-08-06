//
//  ColorfulStyle.swift
//  Memorelo
//
//  Created by Adriel de Souza on 05/08/25.
//

import SwiftUI

enum ColorfulStyle: CaseIterable {
    case pink, blue, yellow, green

    var solidColor: Color {
        switch self {
        case .pink:
            .solidPink
        case .blue:
            .solidBlue
        case .yellow:
            .solidYellow
        case .green:
            .solidGreen
        }
    }

    var translucentColor: Color {
        switch self {
        case .pink:
            .translucentPink
        case .blue:
            .translucentBlue
        case .yellow:
            .translucentYellow
        case .green:
            .translucentGreen
        }
    }
}
