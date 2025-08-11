//
//  MemoriesView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI
import SwiftData

struct MemoriesView: View {
    enum VisualizationStyle: Int {
        case timeline, galery
    }

    @State var visualizationStyle: VisualizationStyle = .timeline
    @State var isNewMemorySheetPresented: Bool = false
    @State var isMemoryDetailsPresented: Bool = false
    @State var selectedMemory: Memory?

    @Query(sort: \Memory.date, order: .reverse) var memories: [Memory]
    @Query(sort: \MemoryAttachment.date, order: .reverse) var attachments: [MemoryAttachment]

    @ViewBuilder
    func timelineContent() -> some View {
        LazyVStack(spacing: 0) {
            ForEach(memories) {memory in
                TimelineEntry(color: .green, memory: memory)
            }
        }
        .clipped()
    }

    @ViewBuilder
    func galeryContent() -> some View {
        FlowLayout(spacing: 8) {
            ForEach(attachments) {attachment in
                MemoryAttachmentItem(attachment, size: 85)?.onTapGesture {
                    if let memory = attachment.attachedTo {
                        isMemoryDetailsPresented = true
                        selectedMemory = memory
                    }
                }
            }
        }
    }

    var body: some View {
        Group {
            if memories.isEmpty {
                MemororeloEmptyState {
                    isNewMemorySheetPresented = true
                }
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
                    .padding(.top, 8)
                }
            }
        }
        .navigationTitle("Memórias")
        .frame(maxHeight: .infinity)
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
        .sheet(isPresented: $isNewMemorySheetPresented) {
            AddMemoryStage1()
        }
        .sheet(isPresented: $isMemoryDetailsPresented) {
            if let selectedMemory {
                MemoryDetails(memory: selectedMemory)
            }
        }
    }
}

#Preview {
    MemoriesView()
}
