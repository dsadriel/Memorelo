//
//  FamilyView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI

struct FamilyView: View {
    var body: some View {
        List {
            ProfieListingItem(name: "Adriel de Souza", email: "adriel@email.com")
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden, edges: .all)
            Text("Membros")
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden, edges: .all)
            ProfieListingItem(name: "João Pedro", relation: "Sobrinho", age: "11 anos")
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden, edges: .all)
        }

        .listStyle(.plain)
        .padding()
        .navigationTitle("Família")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                } label: {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .foregroundStyle(.solidPurple)
                }
            }
        }
    }
}

#Preview {
    TabBar()
}
