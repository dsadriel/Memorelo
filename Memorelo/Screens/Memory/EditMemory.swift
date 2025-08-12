//
//  EditMemory.swift
//  Memorelo
//
//  Created by Adriel de Souza on 11/08/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct EditMemory: View {
    var memory: Memory

    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State var memoryTitle: String = ""
    @State var attachments: [MemoryAttachment] = []
    @State var memoryDate: Date = Date()
    @State var details: String = ""
    @State var participants: [MemberProfile] = []
    @State var location: String = ""
    @State var tags: [String] = []
    @State var tagsField: String = ""

    @State var pickedItems: [PhotosPickerItem] = []
    @State var pickedImages: [Image] = []

    @State var isPhotoPickerPresented: Bool = false
    @State var isDeleteMemoryAlertPresented: Bool = false
    @State var isParticipantsSheetPresented: Bool = false

    func handleTagFieldChange() {
        if tagsField.last == "," {
            let newTag = tagsField.filter {$0 != "," }
            tags.append(newTag)
            tagsField = ""
        }
    }

    var body: some View {
        NavigationStack {

            ScrollView {
                VStack(spacing: 20) {

                    // MARK: - Title
                    MemoreloTextField(
                        text: $memoryTitle,
                        title: "Título da memória",
                        placeholder: "Ex: Primeiro banho de mar do João"
                    )

                    // MARK: - Attachments
                    VStack(spacing: 8) {
                        HStack {
                            Text("Recordações")
                                .font(.body)
                                .foregroundStyle(.labelsPrimary)

                            Spacer()

                            Button {
                                isPhotoPickerPresented = true
                            } label: {

                                Image(systemName: "plus.circle")
                                    .font(.system(.body, weight: .bold))
                                    .foregroundStyle(.solidPurple)
                            }

                        }

                        if attachments.isEmpty {
                            MemororeloEmptyState(
                                title: "Adicionar recordações a esta memória",
                                actionText: "Adicionar recordações"
                            ) {
                                isPhotoPickerPresented = true
                            }
                            .frame(minHeight: 361)

                        } else {
                            FlowLayout(spacing: 8) {
                                ForEach(attachments) { attachment in
                                    MemoryAttachmentItem(attachment, size: 85)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(style: StrokeStyle(lineWidth: 1.5, dash: [20, 10]))
                                    .foregroundStyle(.translucentPurpleWashed)
                            )
                        }
                    }

                    // MARK: - Date
                    MemoreloDateField(
                        title: "Data da memória",
                        value: $memoryDate,
                        displayedComponents: [.date]
                    )

                    // MARK: - Details

                    MemoreloTextField(
                        text: $details,
                        title: "Detalhes do momento",
                        placeholder: "Descreva o que aconteceu, uma conversa, um sentimento...",
                        lineLimit: 10...20
                    )

                    // MARK: - Participants

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
                            ForEach(participants){member in
                                HStack(spacing: 8) {
                                    if let pictureData = member.pictureData, let image = Image(pictureData) {
                                        image
                                            .resizable()
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
                                        Text("Remover").tint(.red)
                                    }
                                }
                            }
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }


                    // MARK: - Location

                    MemoreloTextField(
                        text: $location,
                        title: "Onde aconteceu",
                        placeholder: "Ex: Casa da vovó Bia, Viagem para Gramado",
                        leadingIconName: "map"
                    )

                    // MARK: - Tags
                    MemoreloTextField(
                        text: $tagsField,
                        title: "Tags",
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
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer(minLength: 32)
                    
                    MemoreloButton(text: "Excluir", style: .destructive){
                        isDeleteMemoryAlertPresented = true
                    }
                }
                .padding()
            }

            // PhotoPicker
            .photosPicker(
                isPresented: $isPhotoPickerPresented,
                selection: $pickedItems,
                matching: .images,
                photoLibrary: .shared()
            )
            .onChange(of: pickedItems) { oldValue, newValue in
                Task { @MainActor in
                    
                    // Remove all loose attachments
                    for attachment in attachments {
                        if attachment.attachedTo != nil { continue }
                        attachment.deleteFromFileManager()
                    }
                    attachments.removeAll()
                    
                    for item in pickedItems {
                        if let loadedData = try? await item.loadTransferable(type: Data.self),
                           let newAttachment = MemoryAttachment(attachedTo: nil, kind: .photo, data: loadedData){
                            print("Sucess")
                            attachments.append(newAttachment)
                        } else {
                            print("Failed to load image.")
                        }
                    }
                }
            }

            .navigationTitle("Editar Memória")
            .scrollClipDisabled(true)
            .presentationDragIndicator(.visible)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarTitleDisplayMode(.inline)
            .background(.backgroundsSecondary)
            .toolbarBackground(.backgroundsSecondary)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Salvar") {
                        memory.title = memoryTitle
                        memory.date = memoryDate
                        memory.tags = tags
                        memory.location = location.isEmpty ? nil : location
                        memory.details = details.isEmpty ? nil : details
                        
                        //Remove old attachemnts
                        for oldAttachment in memory.attachments {
                            oldAttachment.deleteFromFileManager()
                            oldAttachment.attachedTo = nil
                        }
                        
                        for newAttachment in attachments {
                            newAttachment.attachedTo = memory
                        }
                        memory.attachments = attachments

                        try? modelContext.save()

                        dismiss()
                    }
                }
            }
            .onAppear {
                memoryTitle = memory.title
                memoryDate =  memory.date
                attachments = memory.attachments
                tags = memory.tags
                location = memory.location ?? ""
                details = memory.details ?? ""
                participants = memory.participants
            }
            .sheet(isPresented: $isParticipantsSheetPresented){
                SelectParticipants(selectedMembers: $participants)
            }
            .alert("Excluir Memória", isPresented: $isDeleteMemoryAlertPresented, actions: {
                Button(role: .destructive) {
                    for attachment in memory.attachments {
                        attachment.deleteFromFileManager()
                        
                        modelContext.delete(attachment)
                    }
                    
                    modelContext.delete(memory)
                    
                    try? modelContext.save()
                    
                    dismiss()
                } label: {
                    Text("Excluir")
                }

                Button("Cancelar", role: .cancel) {}
            })
        }
    }
}

#Preview {
    EditMemory(memory: Memory(title: "Dia dos pais", date: Date(), attachments: [], tags: [], participants: []))
}
