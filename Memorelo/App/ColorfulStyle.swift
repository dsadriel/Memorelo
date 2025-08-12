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
    
    init(from text: String){
        let ascii = Int(text.first?.asciiValue ?? 0)
        let index = (text.count + ascii) % ColorfulStyle.allCases.count
        
        self = ColorfulStyle.allCases[index]
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
