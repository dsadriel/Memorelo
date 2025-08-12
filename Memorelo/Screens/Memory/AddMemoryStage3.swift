//
//  AddMemoryStage3.swift
//  Memorelo
//
//  Created by Adriel de Souza on 09/08/25.
//

import SwiftUI
import SwiftData

struct AddMemoryStage3: View {
    @Environment(\.modelContext) var modelContext
    let sheetDismiss: DismissAction?

    @Binding var memoryTitle: String
    @Binding var attachments: [MemoryAttachment]
    @Binding var memoryDate: Date
    @Binding var details: String
    @Binding var participants: [MemberProfile]
    @Binding var location: String

    @State var tags: [String] = []
    @State var tagsField: String = ""

    func handleTagFieldChange() {
        if tagsField.last == "," {
            let newTag = tagsField.filter {$0 != "," }
            tags.append(newTag)
            tagsField = ""
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text("Organize para depois")
                        .font(.system(.title2, weight: .bold))
                        .foregroundStyle(.labelsPrimary)
                    Text("Passo 3 de 3: A Organização")
                        .font(.callout)
                        .foregroundStyle(.labelsPrimary)
                }
                .padding(.vertical, 16)

                MemoreloTextField(
                    text: $tagsField,
                    title: "Adicione tags para encontrar fácil",
                    placeholder: "Ex: férias, praia, família...",
                    helperText: "Pressione vírgula para criar uma nova tag.",
                    leadingIconName: "tag"
                )
                .onChange(of: tagsField) {handleTagFieldChange()}

                FlowLayout(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        PillLabel(text: tag)
                            .contextMenu {
                                Button(role: .destructive) {
                                    if let index = tags.firstIndex(of: tag) {
                                        tags.remove(at: index)
                                    }
                                } label: {
                                    Label("Remover", systemImage: "trash")
                                        .tint(.red)
                                }
                            }
                    }
                }
            }
            .padding(.all, 16)
        }
        .navigationTitle("Nova memória")
        .scrollClipDisabled(true)
        .presentationDragIndicator(.visible)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .toolbarTitleDisplayMode(.inline)
        .background(.backgroundsSecondary)
        .toolbarBackground(.backgroundsSecondary)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Salvar") {
                    let newMemory = Memory(title: memoryTitle, date: memoryDate, attachments: attachments, tags: tags, location: location, details: details, participants: participants)

                    for attachment in newMemory.attachments {
                        attachment.attachedTo = newMemory
                    }

                    modelContext.insert(newMemory)

                    try? modelContext.save()

                    sheetDismiss?()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMemoryStage3(sheetDismiss: nil, memoryTitle: .constant(""), attachments: .constant([]), memoryDate: .constant(Date()), details: .constant(""), participants: .constant([]), location: .constant(""))
    }
}
