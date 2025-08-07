//
//  TabBar.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI

struct TabBar: View {
    var body: some View {
        TabView {
            Tab("Visão Geral", systemImage: "tray.full") {
                NavigationStack {
                    OverviewView()
                }
            }

            Tab("Memórias", systemImage: "photo.stack") {
                NavigationStack {
                    MemoriesView()
                }
            }

            Tab("Família", systemImage: "figure.and.child.holdinghands") {
                NavigationStack {
                    FamilyView()
                }
            }
        }
        .tint(.solidPurple)
    }
}

#Preview {
    TabBar()
}
