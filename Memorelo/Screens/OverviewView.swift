//
//  OverviewView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI

struct OverviewView: View {

    @ViewBuilder
    func headerText(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .foregroundStyle(.labelsPrimary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    headerText("Destaque")
                    MemoriesEmptyState()
                }

                VStack(alignment: .leading, spacing: 8) {
                    headerText("Próximos marcos")
                }

                VStack(alignment: .leading, spacing: 8) {
                    headerText("Atividades sugeridas")

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(MemoreloApp.activitySuggestions, id: \.self) { suggestion in
                                SuggestionCard(suggestion)
                            }
                        }
                        .scrollTargetLayout()

                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollClipDisabled(true)
                }
            }
        }
        .padding(.all, 16)
        .scrollClipDisabled(true)
        .navigationTitle("Visão Geral")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "photo.badge.plus.fill")
                        .fontWeight(.bold)
                        .foregroundStyle(.solidPurple)
                }
            }
        }
    }
}

#Preview {
    OverviewView()
}
