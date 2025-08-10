//
//  TimelineEntry.swift
//  Memorelo
//
//  Created by Adriel de Souza on 09/08/25.
//

import SwiftUI

struct TimelineEntry: View {

    var color: ColorfulStyle
    var title: String
    var details: String
    var attachments: [MemoryAttachment]

    var body: some View {
        HStack(spacing: 8) {
            Text("15 ago")
                .font(.headline)
                .foregroundStyle(color.solidColor)
                .frame(minWidth: 65)
                .padding(.trailing, 4)

            VStack(alignment: .leading, spacing: 8) {
                Text("Title")
                    .font(.system(.title3, weight: .semibold))
                    .foregroundStyle(color.solidColor)
                Text("Details")
                    .font(.body)
                    .foregroundStyle(.labelsPrimary)
                HStack(spacing: 4) {
                    let willShowMore = attachments.count > 4
                    let limit: Int = willShowMore ? 3 : 4
                    
                    ForEach(attachments[0..<limit]) { att in
                        switch att.kind {
                        case .photo:
                            MemoryAttachmentItem(color: color, photo: Image(.memoryPlaceholder))
                        case .video:
                            MemoryAttachmentItem(color: color, preview: Image(.memoryPlaceholder), duration: "2min")
                        case .audio:
                            MemoryAttachmentItem(color: color, audioDuration: "2min")
                        }
                    }
                    if willShowMore {
                        MemoryAttachmentItem(color: color, moreAmount: attachments.count - 3)
                    }
                }
                .padding(.top, 4)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(color.translucentColor)
            )
            .padding(.vertical, 8)
        }
        .overlay(
            Rectangle()
                .frame(width: 1.5)
                .foregroundColor(color.translucentColor)
                .padding(.leading, 69),
            alignment: .leading
        )
    }
}

#Preview {
    TimelineEntry(color: .green, title: "My Title", details: "Details", attachments: [.init(kind: .photo), .init(kind: .video), .init(kind: .audio), .init(kind: .audio), .init(kind: .audio),])
}
