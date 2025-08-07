//
//  SuggestionCard.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI

struct SuggestionCard: View {
    var color: ColorfulStyle
    var title: String
    var description: String
    var goal: String
    var duration: Int

    var durationText: String {
        if duration > 60 {
            return "\(duration / 60)h\(duration%60)min"
        } else {
            return "\(duration%60)min"
        }
    }

    init(color: ColorfulStyle, title: String, description: String, goal: String, duration: Int) {
        self.color = color
        self.title = title
        self.description = description
        self.goal = goal
        self.duration = duration
    }

    init(title: String, description: String, goal: String, duration: Int) {
        // Generate a deterministic index based on the title's character count and first character's ASCII value
        // This ensures consistent color selection for the same title
        let ascii = Int(title.first?.asciiValue ?? 0)
        let index = (title.count + ascii) % ColorfulStyle.allCases.count
        let color = ColorfulStyle.allCases[index]

        self.init(color: color, title: title, description: description, goal: goal, duration: duration)
    }

    init(_ suggestion: ActivitySuggestion) {
        self.init(title: suggestion.title, description: suggestion.description, goal: suggestion.goal, duration: suggestion.durationInMinutes)
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(.title3, weight: .semibold))
                    .foregroundStyle(color.solidColor)

                Text(description)
                    .font(.body)
                    .foregroundStyle(.labelsPrimary)

            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            HStack(spacing: 4) {
                Text(goal)
                    .font(.caption2)
                    .foregroundStyle(.labelsSecondary)

                Spacer()

                HStack(spacing: 4) {
                    Image(systemName: "clock")
                    Text(durationText)
                }

                .font(.caption)
                .foregroundStyle(.labelsInverted)
                .padding(.all, 4)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(color.solidColor)
                )
            }
        }
        .padding(12)
        .frame(width: 340, height: 153)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(color.translucentColor)
        )
    }
}

#Preview {
    VStack {
        SuggestionCard(
            title: "Hora do desenho em família",
            description: "Todos desenham o que quiserem e depois compartilham suas criações.",
            goal: "Estimular a expressão criativa e promover conversas leves.",

            duration: 30
        )
        SuggestionCard(
            title: "Fazer massinha caseira",
            description: "Produzam juntos massinha com farinha, sal e corante alimentício.",
            goal: "Desenvolver coordenação motora e criar oportunidades de aprendizado sensorial.",

            duration: 40
        )
    }
}
