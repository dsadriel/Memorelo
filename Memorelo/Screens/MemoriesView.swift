//
//  MemoriesView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI

struct MemoriesView: View {
    enum VisualizationStyle: Int {
        case timeline, galery
    }

    var isEmpty: Bool = false
    
    @State var visualizationStyle: VisualizationStyle = .timeline
    
    @ViewBuilder
    func timelineContent() -> some View {
        Text("Linha do tempo")
    }
    
    @ViewBuilder
    func galeryContent() -> some View {
        Text("Galeria")
    }
    

    var body: some View {
        Group {
            if isEmpty {
                MemoriesEmptyState()
                    .padding(.all, 16)
            } else {
                ScrollView {
                    Picker("What is your favorite color?", selection: $visualizationStyle) {
                        Text("Linha do Tempo").tag(VisualizationStyle.timeline)
                        Text("Galeria").tag(VisualizationStyle.galery)
                    }
                    .pickerStyle(.segmented)
                    
                    VStack {
                        switch visualizationStyle {
                        case .timeline:
                            timelineContent()
                        case .galery:
                            galeryContent()
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding(.horizontal, 16)
        .scrollClipDisabled(true)
        .frame(maxHeight: .infinity)
        .navigationTitle("Memórias")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "photo.badge.plus.fill")
                        .foregroundStyle(.solidPurple)
                }
            }
        }
    }
}

#Preview {
    MemoriesView()
}
