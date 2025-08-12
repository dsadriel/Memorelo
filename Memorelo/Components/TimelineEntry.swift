//
//  TimelineEntry.swift
//  Memorelo
//
//  Created by Adriel de Souza on 09/08/25.
//

import SwiftUI

struct TimelineEntry: View {

    var color: ColorfulStyle
    var memory: Memory

    @State var isMemoryDetailsSheetPresented: Bool = false
    
    init(_ memory: Memory){
        self.memory = memory
        self.color = ColorfulStyle(from: memory.title)
    }

    var body: some View {
        HStack(spacing: 8) {
            Text(MemoreloApp.shortDateFormatter.string(from: memory.date))
                .font(.headline)
                .foregroundStyle(color.solidColor)
                .frame(minWidth: 65)
                .padding(.trailing, 4)

            VStack(alignment: .leading, spacing: 8) {
                Text(memory.title)
                    .font(.system(.title3, weight: .semibold))
                    .foregroundStyle(color.solidColor)

                if let details = memory.details {
                    Text(details)
                        .lineLimit(3)
                        .font(.body)
                        .foregroundStyle(.labelsPrimary)
                }

                HStack(spacing: 4) {
                    let limit = memory.attachments.count > 4 ? min(memory.attachments.count, 3) : memory.attachments.count
                    ForEach(memory.attachments[0..<limit]) { attachment in
                        if let item = MemoryAttachmentItem(attachment) {
                            item
                        } else {
                            MemoryAttachmentItem(color: color)
                        }
                    }
                    if limit < memory.attachments.count {
                        MemoryAttachmentItem(color: color, moreAmount: memory.attachments.count - limit)
                    }
                }
                .padding(.top, 4)
            }
            .padding(8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(color.translucentColor)
            )
            .onTapGesture {
                isMemoryDetailsSheetPresented = true
            }
            .padding(.vertical, 8)
        }
        .overlay(
            Rectangle()
                .frame(width: 1.5)
                .foregroundColor(color.translucentColor)
                .padding(.leading, 69),
            alignment: .leading
        )
        .sheet(isPresented: $isMemoryDetailsSheetPresented) {
            MemoryDetails(memory: memory)
        }
    }
}
