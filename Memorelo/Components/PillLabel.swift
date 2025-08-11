//
//  PillLabel.swift
//  Memorelo
//
//  Created by Adriel de Souza on 11/08/25.
//

import SwiftUI

struct PillLabel: View {
    enum PillLabelStyle {
        case `default`, caption2
    }

    var text: String
    var style: PillLabelStyle = .default
    var color: ColorfulStyle?

    var body: some View {
        Text(text)
            .foregroundStyle(color?.solidColor ?? .solidPurple)
            .font(style == .caption2 ? .caption2 : .body)
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(color?.translucentColor ?? .translucentPurple)
            )

    }
}

#Preview {
    PillLabel(text: "Label")
    PillLabel(text: "Label", style: .caption2)
    PillLabel(text: "Label", color: .pink)
}
