//
//  AddMemoryStage3.swift
//  Memorelo
//
//  Created by Adriel de Souza on 09/08/25.
//

import SwiftUI

struct AddMemoryStage3: View {
    let sheetDismiss: DismissAction?

    @State var tags: [String] = []
    @State var tagsField: String = ""

    func handleTagFieldChange() {
        if tagsField.last == "," || tagsField.last == " " {
            let newTag = tagsField.filter { !$0.isWhitespace && $0 != "," }
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
                    helperText: "Pressione espaço ou vírgula para criar uma nova tag.",
                    leadingIconName: "tag"
                )
                .onChange(of: tagsField) {handleTagFieldChange()}

                FlowLayout(spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption)
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
        .toolbar{
            ToolbarItem(placement: .confirmationAction){
                Button("Salvar"){
                    sheetDismiss?()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddMemoryStage3(sheetDismiss: nil)
    }
}
