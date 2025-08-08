//
//  MemberDetailsView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 07/08/25.
//

import SwiftUI

struct MemberDetailsView: View {
    @Environment(\.dismiss) var dismiss

    var member: MemberProfile
    var profilePicture: Image? {
        if let data = member.pictureData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        } else {
            return nil
        }
    }

    @State var isEditMemberSheetPresented: Bool = false
    @State var isArchiveMemberAlertPresented: Bool = false
    @State var isPreviewing: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {

                if let profilePicture {
                    profilePicture
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    Image(systemName: "person.fill")
                        .frame(width: 150, height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.fillsSecondary)
                        )
                }

                VStack(spacing: 0) {
                    Text(member.name)
                        .font(.system(.title, weight: .bold))
                    Text(member.ageString)
                        .font(.caption)
                }
                .foregroundStyle(.labelsPrimary)

                Rectangle()
                    .frame(height: 16)
                    .foregroundStyle(.transparent)

                Text("DADOS PESSOAIS")
                    .font(.footnote)
                    .foregroundStyle(.labelsSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 7)

                MemoreloTextField(text: .constant(member.relation), style: .readonly, title: "Relação")
                MemoreloTextField(text: .constant(member.birthday.description), style: .readonly, title: "Data de nascimento")
            }
        }
        .padding()
        .scrollClipDisabled(true)
        .navigationTitle("Membro")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isArchiveMemberAlertPresented = true
                } label: {
                    Image(systemName: "tray.and.arrow.down.fill")
                        .fontWeight(.bold)
                        .foregroundStyle(.solidPurple)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isEditMemberSheetPresented = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .fontWeight(.bold)
                        .foregroundStyle(.solidPurple)
                }
            }
        }
        .sheet(isPresented: $isEditMemberSheetPresented) {
            AddEditMemberView(memberToEdit: member)
        }
        .alert("Arquivar Membro", isPresented: $isArchiveMemberAlertPresented, actions: {
            Button(role: .destructive) {
                member.isArchived = true
                dismiss()
            } label: {
                Text("Arquivar")
            }

            Button("Cancelar", role: .cancel) {}
        }, message: {
            Text("Ao fazer isso, todas as memórias deste membro serão arquivas também, e não estarão mais disponíveis na galeria e linha do tempo.")
        })
    }

}

#Preview {
    NavigationStack {
        MemberDetailsView(member: MemberProfile(name: "João", relation: "Sobrinho", birthday: Date()))
    }
}
