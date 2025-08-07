//
//  MemoreloButton.swift
//  Memorelo
//
//  Created by Adriel de Souza on 05/08/25.
//

import SwiftUI

enum ButtonStyle: Hashable {
    case primary, secondary, disabled, destructive
    case colorful(ColorfulStyle)
}

struct MemoreloButton: View {
    var text: String
    var style: ButtonStyle = .primary
    var action: @MainActor () -> Void

    var labelColor: Color {
        switch style {
        case .primary, .colorful:
            .labelsInverted
        case .secondary:
            .solidPurple
        case .destructive:
            .solidRed
        case .disabled:
            .labelsTertiary
        }
    }

    var backgroundColor: Color {
        switch style {
        case .primary:
            .solidPurple
        case .secondary:
            .translucentPurpleWashed
        case .destructive:
            .translucentRed
        case .colorful(let style):
            style.solidColor
        case .disabled:
            .fillsTertiary
        }
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.system(.body, weight: .semibold))
                .foregroundStyle(labelColor)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(backgroundColor)
                )
        }
    }
}

#Preview {
    VStack {
        MemoreloButton(text: "Test", style: .primary) {}
        MemoreloButton(text: "Test", style: .secondary) {}
        MemoreloButton(text: "Test", style: .destructive) {}
        MemoreloButton(text: "Test", style: .disabled) {}
        MemoreloButton(text: "Test", style: .colorful(.yellow)) {}
    }
}
