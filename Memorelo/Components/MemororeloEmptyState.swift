//
//  MemoriesEmptyState.swift
//  Memorelo
//
//  Created by Adriel de Souza on 05/08/25.
//

import SwiftUI

struct MemororeloEmptyState: View {
    var iconName: String
    var title: String
    var subtitle: String?
    var actionText: String?
    var action: () -> Void

    init(iconName: String = "tray", title: String = "Nenhuma memória registrada.", subtitle: String? = "Você pode salvar fotos, vídeos ou áudios.", actionText: String? = "Salvar nova memória", action: @escaping () -> Void = {}) {
        self.iconName = iconName
        self.title = title
        self.subtitle = subtitle
        self.actionText = actionText
        self.action = action
    }

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(.system(.title2, weight: .bold))
                    .foregroundStyle(.solidWashedPurple)
                VStack {
                    Text(title)
                        .font(.system(.callout, weight: .semibold))
                    if let subtitle {
                        Text(subtitle)
                            .font(.system(.callout, weight: .regular))
                    }
                }
                .foregroundStyle(.solidWashedPurple)

            }
            if let actionText {
                MemoreloButton(text: actionText) {
                    action()
                }
            }
           
        }
        .frame(minWidth: 361, minHeight: 200, maxHeight: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [20, 10]))
                .foregroundStyle(.translucentPurpleWashed)
        )
    }
}

#Preview {
    MemororeloEmptyState()
}
