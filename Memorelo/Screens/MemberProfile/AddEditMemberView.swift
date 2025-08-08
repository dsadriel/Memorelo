//
//  AddEditMemberView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 08/08/25.
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
        if let profilePictureData {
            return Image(profilePictureData)
        }
        return nil
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

    var memberAgeString: String? {
        if name.isEmpty { return nil }

        let firstName: String
        let dividerIndex = name.firstIndex(of: " ") ?? name.endIndex
        firstName = String(name[..<dividerIndex])

        return "\(firstName) tem \(birtday.ageString.lowercased())"
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
                        helperText: isEditing ? "A relação será alterada somente para você. Co-cuidadores devem alterar ela em seus próprios aplicativos." : "Essa relação é visível somente para você."
                    )

                    MemoreloDateField(title: "Data de Nascimento", value: $birtday, displayedComponents: [.date], helperText: memberAgeString)
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
