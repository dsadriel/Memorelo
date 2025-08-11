//
//  MemoryAttachment.swift
//  Memorelo
//
//  Created by Adriel de Souza on 09/08/25.
//

import SwiftData
import SwiftUI

@Model
class MemoryAttachment: Identifiable {
    enum Kind: Codable {
        case photo, video, audio
    }

    var id: UUID
    var attachedTo: Memory?
    var kind: Kind
    var date: Date
    var duration: Time?

    private var baseURL: URL? {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    var url: URL? {
        baseURL?.appendingPathComponent(id.uuidString)
    }

    init(kind: Kind) {
        self.id = UUID()
        self.kind = kind
        self.date = Date()
    }

    // MARK: - Init with file saving
    init?(attachedTo memory: Memory?, kind: Kind, data: Data) {
        let newId = UUID()
        self.id = newId
        self.kind = kind
        self.attachedTo = memory
        self.date = Date()
        self.duration = nil

        guard let fileURL = baseURL?.appendingPathComponent(newId.uuidString) else {
            print("Could not get base documents directory.")
            return nil
        }

        do {
            try data.write(to: fileURL, options: .atomic)
            print("Saved file to \(fileURL.path)")
        } catch {
            print("Failed to save file: \(error.localizedDescription)")
            return nil
        }
    }

    // MARK: - File deletion
    func deleteFromFileManager() {
        guard let fileURL = url else { return }
        do {
            try FileManager.default.removeItem(at: fileURL)
            print("Deleted file at \(fileURL.path)")
        } catch {
            print("Could not delete file: \(error.localizedDescription)")
        }
    }
}
