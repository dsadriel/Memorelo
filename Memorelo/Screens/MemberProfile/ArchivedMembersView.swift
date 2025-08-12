//
//  ArchivedMembersView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 07/08/25.
//

import SwiftData
import SwiftUI

struct ArchivedMembersView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @Query(filter: #Predicate<MemberProfile> { $0.isArchived }) var archivedMembers: [MemberProfile]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    if !archivedMembers.isEmpty {
                        ForEach(archivedMembers) { member in
                            ProfieListingItem(member)
                                .contextMenu {
                                    Button(role: .destructive) {
                                        withAnimation {
                                            modelContext.delete(member)
                                            try? modelContext.save()
                                        }
                                    } label: {
                                        Label("Excluir membro", systemImage: "trash")
                                            .tint(.red)
                                    }
                                }
                        }
                    } else {
                        MemororeloEmptyState(iconName: "person.fill.questionmark", title: "Sem membros arquivados", subtitle: nil, actionText: nil){}
                    }
                }
            }
            .padding()
            .scrollClipDisabled(true)
            .navigationTitle("Membros arquivados")
            .toolbarTitleDisplayMode(.inline)
            .presentationDetents([.medium])
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Fechar")
                            .foregroundStyle(.solidPurple)
                    }
                }
            }
            .background(.backgroundsSecondary)
        }
    }
}

#Preview {
    ArchivedMembersView()
}
