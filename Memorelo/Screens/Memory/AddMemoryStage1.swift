//
//  AddMemoryStage1.swift
//  Memorelo
//
//  Created by Adriel de Souza on 08/08/25.
//

import PhotosUI
import SwiftUI

struct AddMemoryStage1: View {
    @Environment(\.dismiss) private var sheetDismiss

    @State var memoryTitle: String = ""
    @State var attachments: [MemoryAttachment] = []
    @State var memoryDate: Date = Date()
    @State var pickedItems: [PhotosPickerItem] = []
    @State var pickedImages: [Image] = []

    @State var didUserSetDateManually: Bool = false
    @State var isNextStagePresented: Bool = false
    @State var isPhotoPickerPresented: Bool = false

    @ViewBuilder
    func recordationsList() -> some View {
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
    }

    var body: some View {
        NavigationStack {

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

                    recordationsList()

                    MemoreloDateField(
                        title: "Data da memória",
                        value: $memoryDate,
                        displayedComponents: [.date],
                        helperText: didUserSetDateManually
                            ? ""
                            : "Nós tentamos adivinhar a data pelos anexos. Se não estiver certa, é só corrigir!"
                    )
                }
                .onChange(of: memoryDate) {
                    didUserSetDateManually = true
                }
                .padding(.all, 16)
            }
            .scrollClipDisabled(true)
            .background(.backgroundsSecondary)

            // PhotoPicker
            .photosPicker(
                isPresented: $isPhotoPickerPresented,
                selection: $pickedItems,
                matching: .images,
                photoLibrary: .shared()
            )
            .onChange(of: pickedItems) { oldValue, newValue in
                Task { @MainActor in
                    
                    // Remove all attachments from the disk
                    for attachment in attachments {
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

            // Naivigation
            .navigationTitle("Nova memória")
            .presentationDragIndicator(.visible)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.backgroundsSecondary)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Avançar") {
                        isNextStagePresented = true
                    }
                    .disabled(attachments.isEmpty || memoryTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .navigationDestination(isPresented: $isNextStagePresented) {
                AddMemoryStage2(
                    sheetDismiss: sheetDismiss,
                    memoryTitle: $memoryTitle,
                    attachments: $attachments,
                    memoryDate: $memoryDate
                )
            }
        }
    }
}

#Preview {
    AddMemoryStage1()
}
