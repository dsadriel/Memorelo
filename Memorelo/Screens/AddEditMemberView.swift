//
//  AddEditMemberView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 07/08/25.
//

import PhotosUI
import SwiftUI

struct AddEditMemberView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @State var relation: String = ""
    @State var name: String = ""
    @State var birtday: Date = Date()
    @State var triedToSave: Bool = false
    @State var profilePictureData: Data?
    var profilePicture: Image? {
        if let data = profilePictureData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            return nil
        }
    }
    @State var imageSelection: PhotosPickerItem?

    var memberToEdit: MemberProfile?
    var isEditing: Bool { memberToEdit != nil }
    var isFormValid: Bool {
        let isFilled = !name.isEmpty && !relation.isEmpty
        if let member = memberToEdit {
            return isFilled && (member.name != name || member.relation != relation || member.birthday != birtday || member.pictureData != profilePictureData)
        } else {
            return isFilled
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    PhotosPicker(
                        selection: $imageSelection,
                        matching: .images,
                        photoLibrary: .shared()
                    ) {

                        Group {
                            if let profilePicture {
                                profilePicture
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            } else {
                                Image(systemName: "person.crop.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundStyle(.solidPurple)
                                    .frame(width: 150, height: 150)
                                    .background(
                                        RoundedRectangle(cornerRadius: 16)
                                            .foregroundStyle(.translucentPurpleWashed)
                                    )
                            }
                        }
                        .onChange(of: imageSelection) {
                            Task { @MainActor in
                                if let loadedData = try? await imageSelection?.loadTransferable(type: Data.self) {
                                    profilePictureData = loadedData
                                } else {
                                    print("Failed to load image.")
                                }
                            }
                        }

                    }
                    .buttonStyle(.borderless)

                    Rectangle()
                        .frame(height: 16)
                        .foregroundStyle(.transparent)

                    Text("DADOS PESSOAIS")
                        .font(.footnote)
                        .foregroundStyle(.labelsSecondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 7)

                    MemoreloTextField(
                        text: $name,
                        style: triedToSave && name.isEmpty ? .error : .default,
                        title: "Nome",
                        placeholder: "João"
                    )

                    MemoreloTextField(
                        text: $relation,
                        style: triedToSave && relation.isEmpty ? .error : .default,
                        title: "Relação",
                        placeholder: "Filho",
                        helperText: "Essa relação é visível somente para você."
                    )
                    MemoreloTextField(text: .constant("FIXXXX"), style: .readonly, title: "Data de nascimento")
                }
            }
            .navigationTitle(isEditing ? "Editar Membro" : "Novo Membro")
            .scrollClipDisabled(true)
            .padding()
            .presentationDragIndicator(.visible)
            .background(.backgroundSecondary)
            .toolbarBackground(.backgroundSecondary)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        if isEditing, let memberToEdit {
                            memberToEdit.name = name
                            memberToEdit.relation = relation
                            memberToEdit.birthday = birtday
                            memberToEdit.pictureData = profilePictureData

                            dismiss()
                        } else {
                            triedToSave = true
                            if !relation.isEmpty && !name.isEmpty {
                                let newMember = MemberProfile(name: name, relation: relation, birthday: birtday, pictureData: profilePictureData)
                                modelContext.insert(newMember)
                                dismiss()
                            }
                        }

                    } label: {
                        Text(isEditing ? "Salvar" : "Adicionar")
                            .foregroundStyle(isFormValid ? .solidPurple : .labelsSecondary)
                    }
                    .disabled(!isFormValid)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                            .foregroundStyle(.solidPurple)
                    }
                }
            }
            .onAppear {
                if let memberToEdit {
                    name = memberToEdit.name
                    relation = memberToEdit.relation
                    birtday = memberToEdit.birthday
                    profilePictureData = memberToEdit.pictureData
                }
            }
        }
        .background(.backgroundSecondary)
    }

}

#Preview {
    AddEditMemberView()
}
