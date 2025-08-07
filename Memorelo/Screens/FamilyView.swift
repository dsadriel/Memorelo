//
//  FamilyView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI

struct FamilyView: View {
    @State var isArchivedMemberListPresented: Bool = false
    @State var isAddMemberPresented: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ProfieListingItem(name: "Adriel de Souza", email: "adriel@email.com")

                VStack(spacing: 8) {
                    Text("Membros")
                        .font(.headline)
                        .foregroundStyle(Color.SystemColors.labelsPrimary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ProfieListingItem(name: "João Pedro", relation: "Sobrinho", age: "11 anos")
                }

                HStack(spacing: 4) {
                    Spacer()
                    Text("Membros Arquivados")
                    Image(systemName: "chevron.right")
                }
                .onTapGesture {
                    isArchivedMemberListPresented.toggle()
                }
                .font(.footnote)
                .foregroundStyle(Color.SystemColors.labelsSecondary)
            }
        }
        .padding()
        .scrollClipDisabled(true)
        .navigationTitle("Família")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isAddMemberPresented.toggle()
                } label: {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .foregroundStyle(.solidPurple)
                }
            }
        }
        
        .sheet(isPresented: $isArchivedMemberListPresented){
            EmptyView()
        }
        .sheet(isPresented: $isAddMemberPresented){
            EmptyView()
        }
        

    }
}

#Preview {
    FamilyView()
}
