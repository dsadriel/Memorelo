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
    @State var selectedMemory: Memory?

    @Query(sort: \Memory.date, order: .reverse) var memories: [Memory]
    @Query(sort: \MemoryAttachment.date, order: .reverse) var attachments: [MemoryAttachment]

    @ViewBuilder
    func timelineContent() -> some View {
        LazyVStack(spacing: 0) {
            ForEach(memories) {memory in
                TimelineEntry(memory)
            }
        }
        .clipped()
    }

    @ViewBuilder
    func galeryContent() -> some View {
        FlowLayout(spacing: 4) {
            ForEach(attachments) {attachment in
                if let item = MemoryAttachmentItem(attachment, size: 85) {
                    item.onTapGesture {
                        if let memory = attachment.attachedTo {
                            selectedMemory = memory
                        }
                    }
                }
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
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
        .onTapGesture {
            selectedMemory = nil
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
        .sheet(item: $selectedMemory) {
            memory in MemoryDetails(memory: memory)
        }
    }
}

#Preview {
    MemoriesView()
}
