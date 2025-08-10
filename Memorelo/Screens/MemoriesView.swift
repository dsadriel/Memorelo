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
    @State var isNewMemorySheetPresented: Bool = false


    @ViewBuilder
    func timelineContent() -> some View {
        LazyVStack(spacing: 0){
            ForEach(1...20, id: \.self) { _ in
                TimelineEntry(color: .green, title: "My Title", details: "Details", attachments: [.init(kind: .photo), .init(kind: .video), .init(kind: .audio), .init(kind: .audio), .init(kind: .audio),])
            }
        }
        .clipped()
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
                    Picker("", selection: $visualizationStyle) {
                        Text("Linha do Tempo").tag(VisualizationStyle.timeline)
                        Text("Galeria").tag(VisualizationStyle.galery)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 16)

                    VStack {
                        switch visualizationStyle {
                        case .timeline:
                            timelineContent()
                        case .galery:
                            galeryContent()
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .padding(.top, 8)
            }
        }
        .frame(maxHeight: .infinity)
        .navigationTitle("Memórias")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isNewMemorySheetPresented = true
                } label: {
                    Image(systemName: "photo.badge.plus.fill")
                        .fontWeight(.bold)
                        .foregroundStyle(.solidPurple)
                }
            }
        }
        .background(.backgroundsPrimary)
        .sheet(isPresented: $isNewMemorySheetPresented){
            AddMemoryStage1()
        }
    }
}

#Preview {
    MemoriesView()
}
