//
//  LabelWithIcon.swift
//  Memorelo
//
//  Created by Adriel de Souza on 11/08/25.
//

import SwiftUI

struct LabelWithIcon: View {
    enum LabelWithIconStyle {
        case `default`, caption2
    }

    var iconName: String
    var text: String
    var style: LabelWithIconStyle = .default
    var colorStyle: ColorfulStyle?
    var color: Color?

    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: iconName)
            Text(text)
        }
        .padding(4)
        .foregroundStyle(colorStyle?.solidColor ?? color ?? .solidPurple)
        .font(style == .caption2 ? .caption2 : .body)
    }
}

#Preview {
    LabelWithIcon(iconName: "house.fill", text: "Label")
    LabelWithIcon(iconName: "house.fill", text: "Label", style: .caption2)
}
