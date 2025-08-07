//
//  MemoriesEmptyState.swift
//  Memorelo
//
//  Created by Adriel de Souza on 05/08/25.
//

import SwiftUI

struct MemoriesEmptyState: View {
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                Image(systemName: "tray")
                    .font(.system(.title2, weight: .bold))
                    .foregroundStyle(.solidWashedPurple)
                VStack {
                    Text("Nenhuma memória registrada.")
                        .font(.system(.callout, weight: .semibold))
                        .foregroundStyle(.solidWashedPurple)
                    Text("Você pode salvar fotos, vídeos ou áudios.")
                        .font(.system(.callout, weight: .regular))
                        .foregroundStyle(.solidWashedPurple)
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
    MemoriesEmptyState()
}
