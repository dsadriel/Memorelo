//
//  MemoryAttachment.swift
//  Memorelo
//
//  Created by Adriel de Souza on 09/08/25.
//

import SwiftUI

class MemoryAttachment: Identifiable {
    enum Kind {
        case photo, video, audio
    }

    var id: UUID
    var attachedTo: UUID
    var kind: Kind
    var date: Date
    var url: URL
    var previewURL: URL?
    var duration: Time?
    
    init(kind: Kind){
        self.id = UUID()
        self.attachedTo = UUID()
        self.kind = kind
        self.date = Date()
        self.url = URL(fileURLWithPath: "")
    }

    init?(attachedTo: UUID, kind: Kind, data: Data) {
//        self.id = UUID()
//        self.kind = kind
//        self.attachedTo = attachedTo
//
//        do {
//            if let baseURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
//                let urlString = URL(fileURLWithPath: "\(baseURL.path)/memory-\(attachedTo)/\(kind)/\(self.id)")
//
//                try data.write(to: urlString)
//
//                self.url = urlString
//            } else {
//                return nil
//            }
//        } catch {
//            return nil
//        }
        return nil
    }
}
