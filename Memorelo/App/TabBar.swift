//
//  TabBar.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI
import SwiftData

struct TabBar: View {
    @Environment(\.modelContext) var modelContext
    
    @Query(filter: #Predicate<MemoryAttachment> {$0.attachedTo == nil}) var loseAttachments: [MemoryAttachment]
    
    var body: some View {
        TabView {
//            Tab("Visão Geral", systemImage: "tray.full") {
//                NavigationStack {
//                    OverviewView()
//                }
//            }

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
        .onAppear{
            for loseAttachment in loseAttachments {
                loseAttachment.deleteFromFileManager()
                modelContext.delete(loseAttachment)
            }
        }
    }
}

#Preview {
    TabBar()
}
