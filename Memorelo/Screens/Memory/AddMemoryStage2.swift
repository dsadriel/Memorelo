//
//  AddMemoryStage2.swift
//  Memorelo
//
//  Created by Adriel de Souza on 09/08/25.
//

import SwiftUI

struct AddMemoryStage2: View {
    let sheetDismiss: DismissAction?
    @Environment(\.dismiss) var dismiss

    @Binding var memoryTitle: String
    @Binding var attachments: [MemoryAttachment]
    @Binding var memoryDate: Date

    @State var details: String = ""
    @State var participants: [MemberProfile] = []
    @State var location: String = ""

    @State var didUserSetDateManually: Bool = false
    @State var isNextStagePresented: Bool = false
    @State var isParticipantsSheetPresented: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                VStack(spacing: 4) {
                    Text("Conte a história")
                        .font(.system(.title2, weight: .bold))
                        .foregroundStyle(.labelsPrimary)
                    Text("Passo 2 de 3: O Contexto")
                        .font(.callout)
                        .foregroundStyle(.labelsPrimary)
                }
                .padding(.vertical, 16)

                MemoreloTextField(
                    text: $details,
                    title: "Como foi esse momento?",
                    placeholder: "Descreva o que aconteceu, uma conversa, um sentimento...",
                    lineLimit: 10...20
                )

                VStack(spacing: 8) {
                    HStack {
                        Text("Quem estava lá?")
                            .font(.body)
                            .foregroundStyle(.labelsPrimary)

                        Spacer()

                        Button {
                            isParticipantsSheetPresented = true
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.system(.body, weight: .bold))
                                .foregroundStyle(.solidPurple)
                        }

                    }
                    Text("Toque para adicionar os membros da família que participaram.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    FlowLayout {
                        ForEach(participants) {member in
                            HStack(spacing: 8) {
                                if let pictureData = member.pictureData, let image = Image(pictureData) {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 64, height: 64)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 8)
                                        )
                                }

                                Text(member.firstName)
                                    .font(.body)
                            }
                            .foregroundStyle(.solidPurple)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.translucentPurple)
                            )
                            .contextMenu {
                                Button(role: .destructive) {
                                    participants.removeAll(where: { $0.id == member.id })
                                } label: {
                                    Label("Remover", systemImage: "trash").tint(.red)
                                }
                            }
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }

                MemoreloTextField(
                    text: $location,
                    title: "Onde aconteceu?",
                    placeholder: "Ex: Casa da vovó Bia, Viagem para Gramado",
                    leadingIconName: "map"
                )
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
                Button("Avançar") {
                    isNextStagePresented = true
                }
            }
        }
        .navigationDestination(isPresented: $isNextStagePresented) {
            AddMemoryStage3(sheetDismiss: sheetDismiss, memoryTitle: $memoryTitle, attachments: $attachments, memoryDate: $memoryDate, details: $details, participants: $participants, location: $location)
        }
        .sheet(isPresented: $isParticipantsSheetPresented) {
            SelectParticipants(selectedMembers: $participants)
        }
    }
}

#Preview {
    NavigationStack {
        AddMemoryStage2(sheetDismiss: nil, memoryTitle: .constant(""), attachments: .constant([]), memoryDate: .constant(Date()))
    }
}
