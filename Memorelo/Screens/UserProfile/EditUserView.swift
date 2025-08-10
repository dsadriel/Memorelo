//
//  EditUserView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 07/08/25.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditUserView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @Query var users: [UserProfile]
    var user: UserProfile {
        guard let user = users.first else {
            dismiss()
            return UserProfile(name: "", email: "")
        }
        return user
    }

    @State var name: String = ""
    @State var birtday: Date = Date()

    @State var profilePictureData: Data?
    var profilePicture: Image? {
        if let profilePictureData {
            return Image(profilePictureData)
        }
        return nil
    }
    @State var imageSelection: PhotosPickerItem?
    @State var isDeleteAccountAlertPresented: Bool = false

    var isFormValid: Bool {
        let isFilled = !name.isEmpty
        return isFilled
            && (user.name != name || user.birthday != birtday
                    || user.pictureData != profilePictureData)
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
                        style: .default,
                        title: "Nome",
                        placeholder: "João"
                    )

                    MemoreloDateField(title: "Data de Nascimento", value: $birtday, displayedComponents: [.date])

                    MemoreloTextField(
                        text: .constant(user.email),
                        style: .readonly,
                        title: "E-mail",
                        helperText: "Seu e-mail não pode ser alterado pois está vinculado a sua conta Apple"
                    )

                    Rectangle()
                        .frame(height: 32)
                        .foregroundStyle(.transparent)

                    MemoreloButton(text: "Excluir minha conta", style: .destructive) {
                        isDeleteAccountAlertPresented = true
                    }
                }
            }
            .navigationTitle("Editar seu perfil")
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
                        user.name = name
                        user.birthday = birtday
                        user.pictureData = profilePictureData

                        dismiss()
                    } label: {
                        Text("Salvar")
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
            .alert(
                "Excluir conta",
                isPresented: $isDeleteAccountAlertPresented,
                actions: {
                    Button(role: .destructive) {

                        modelContext.delete(user)
                        dismiss()
                    } label: {
                        Text("Excluir conta")
                    }

                    Button("Cancelar", role: .cancel) {}
                },
                message: {
                    Text(
                        "Ao excluir sua conta você não terá mais acesso a seu grupo familiar. Suas memórias continuarão visíveis aos outro Co-Cuidadores, caso existam."
                    )
                }
            )
            .onAppear {
                name = user.name
                birtday = user.birthday ?? Date()
                profilePictureData = user.pictureData
            }
        }
        .background(.backgroundsSecondary)
    }
}

#Preview {
    EditUserView()
}
