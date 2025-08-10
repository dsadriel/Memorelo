//
//  AddMemoryStage1.swift
//  Memorelo
//
//  Created by Adriel de Souza on 08/08/25.
//

import SwiftUI

struct AddMemoryStage1: View {
    @Environment(\.dismiss) private var sheetDismiss

    @State var memoryTitle: String = ""
    @State var attachments: [Int] = []
    @State var memoryDate: Date = Date()
    @State var didUserSetDateManually: Bool = false
    @State var isNextStagePresented: Bool = false

    var body: some View {
        NavigationStack{
            
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text("Adicione uma nova memória")
                        .font(.system(.title2, weight: .bold))
                        .foregroundStyle(.labelsPrimary)
                    Text("Passo 1 de 3: O Essencial")
                        .font(.callout)
                        .foregroundStyle(.labelsPrimary)
                }
                .padding(.vertical, 16)

                MemoreloTextField(
                    text: $memoryTitle,
                    title: "Dê um título para a memória",
                    placeholder: "Ex: Primeiro banho de mar do João"
                )

                VStack(spacing: 8) {
                    HStack {
                        Text("Recordações")
                            .font(.body)
                            .foregroundStyle(.labelsPrimary)

                        Spacer()

                        Button {

                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.system(.body, weight: .bold))
                                .foregroundStyle(.solidPurple)
                        }

                    }

                    MemoriesEmptyState()
                }

                MemoreloDateField(
                    title: "Data da memória",
                    value: $memoryDate,
                    displayedComponents: [.date],
                    helperText: didUserSetDateManually
                        ? "" : "Nós tentamos adivinhar a data pelos anexos. Se não estiver certa, é só corrigir!"
                )
                .onChange(of: memoryDate) {
                    didUserSetDateManually = true
                }
            }
            .padding(.all, 16)
        }
        .navigationTitle("Nova memória")
        .scrollClipDisabled(true)
        .padding()
        .presentationDragIndicator(.visible)
        .toolbarBackgroundVisibility(.visible, for: .navigationBar)
        .toolbarTitleDisplayMode(.inline)
        .background(.backgroundsSecondary)
        .toolbarBackground(.backgroundsSecondary)
        .toolbar{
            ToolbarItem(placement: .confirmationAction){
                Button("Avançar"){
                    isNextStagePresented = true
                }
            }
        }
        .navigationDestination(isPresented: $isNextStagePresented){
            AddMemoryStage2(sheetDismiss: sheetDismiss)
        }
    }
    }

}

#Preview {
 AddMemoryStage1()
}
