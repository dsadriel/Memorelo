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

    @Query(filter: #Predicate<MemoryAttachment> { $0.attachedTo == nil }) var looseAttachments: [MemoryAttachment]
    @Query var allAttachments: [MemoryAttachment]

    func cleanLooseAttachments() {
        // Delete Lose Attachments
        for attachment in looseAttachments {
            attachment.deleteFromFileManager()
            modelContext.delete(attachment)
        }

        // Check if there are files that aren't linked to a attachment
        let fm = FileManager.default

        if let baseURL = fm.urls(for: .documentDirectory, in: .userDomainMask).first {
            do {
                let contents = try fm.contentsOfDirectory(atPath: baseURL.path())

                for idString in contents {
                    let id = UUID(uuidString: idString)!

                    if !allAttachments.contains(where: { $0.id == id }) {
                        let fileURL = baseURL.appendingPathComponent(idString)
                        try FileManager.default.removeItem(at: fileURL)
                    }
                }
                print(contents)
            } catch {
                print("Error on cleaning loose attachments: \(error.localizedDescription)")
            }
        }

        try? modelContext.save()
    }

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
    }
}

#Preview {
    TabBar()
}
