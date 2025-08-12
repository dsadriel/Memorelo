//
//  FamilyView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftData
import SwiftUI

struct FamilyView: View {
    @Environment(\.modelContext) var modelContext

    @Query(filter: #Predicate<MemberProfile> { !$0.isArchived }) var members: [MemberProfile]
    @Query(filter: #Predicate<MemberProfile> { $0.isArchived }) var archivedMembers: [MemberProfile]
    @Query var users: [UserProfile]

    var user: UserProfile {
        guard let user = users.first else {
            return UserProfile(name: "", email: "")
        }
        return user
    }

    @State var isArchivedMemberListPresented: Bool = false
    @State var isAddMemberPresented: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ProfieListingItem(user)

                VStack(spacing: 8) {
                    Text("Membros")
                        .font(.headline)
                        .foregroundStyle(.labelsPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if !members.isEmpty {
                        ForEach(members) { member in
                            ProfieListingItem(member)
                        }
                    } else {
                        MemororeloEmptyState(iconName: "person.fill.questionmark", title: "Sua família está vazia", subtitle: "Adicione membros para salvar recordações.", actionText: "Adicionar membro"){
                            isAddMemberPresented = true
                        }
                        .frame(maxHeight: .infinity)
                    }
                }

                if !archivedMembers.isEmpty {
                    HStack(spacing: 4) {
                        Spacer()
                        Text("Membros Arquivados")
                        Image(systemName: "chevron.right")
                    }
                    .onTapGesture {
                        isArchivedMemberListPresented.toggle()
                    }
                    .font(.footnote)
                    .foregroundStyle(.labelsSecondary)
                }
            }
            .padding()
        }
        .scrollClipDisabled(true)
        .navigationTitle("Família")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAddMemberPresented.toggle()
                } label: {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .fontWeight(.bold)
                        .foregroundStyle(.solidPurple)
                }
            }
        }
        .sheet(isPresented: $isArchivedMemberListPresented) {
            ArchivedMembersView()
        }

        .sheet(isPresented: $isAddMemberPresented) {
            AddEditMemberView()
        }
        .onAppear {
            if users.isEmpty {
                let defaultUser = UserProfile(name: "Cuidador(a)", email: "cuidador_a@icloud.com")

                modelContext.insert(defaultUser)
            }
        }
        .background(.backgroundsPrimary)
    }
}

#Preview {
    FamilyView()
}
