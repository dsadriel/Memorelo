//
//  FamilyView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI
import SwiftData

struct FamilyView: View {
    @Environment(\.modelContext) var modelContext

    @Query(filter: #Predicate<MemberProfile> {!$0.isArchived}) var members: [MemberProfile]
    @Query(filter: #Predicate<MemberProfile> {$0.isArchived}) var archivedMembers: [MemberProfile]

    @State var isArchivedMemberListPresented: Bool = false
    @State var isAddMemberPresented: Bool = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ProfieListingItem(name: "Adriel de Souza", email: "adriel@email.com")

                if !members.isEmpty {
                    VStack(spacing: 8) {
                        Text("Membros")
                            .font(.headline)
                            .foregroundStyle(.labelsPrimary)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        ForEach(members) { member in
                            ProfieListingItem(member)
                        }
                    }
                } else {
                    Text("Sem membros")
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

    }
}

#Preview {
    FamilyView()
}
