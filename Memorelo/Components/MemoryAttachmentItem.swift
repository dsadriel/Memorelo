//
//  MemoryAttachmentItem.swift
//  Memorelo
//
//  Created by Adriel de Souza on 09/08/25.
//

import SwiftUI

struct MemoryAttachmentItem: View {
    enum Style {
        case photo, video, audio, more
    }

    var color: ColorfulStyle?
    var style: Style = .more
    var text: String?
    var image: Image?

    init(color: ColorfulStyle? = nil, audioDuration: String) {
        self.color = color
        self.style = .audio
        self.text = audioDuration
    }

    init(color: ColorfulStyle? = nil, moreAmount: Int) {
        self.color = color
        self.style = .more
        self.text = "+\(moreAmount)"
    }

    init(color: ColorfulStyle? = nil, photo: Image) {
        self.color = color
        self.style = .photo
        self.image = photo
    }

    init(color: ColorfulStyle? = nil, preview: Image, duration: String) {
        self.color = color
        self.style = .video
        self.image = preview
        self.text = duration
    }
    
    var size: CGFloat = 65
    
    @ViewBuilder
    func imageView() -> some View {
        Group {
            if let image {
                image
                    .resizable()
            } else {
                Image(.memoryPlaceholder)
                    .resizable()
            }
        }
        .scaledToFill()
        .clipped()
        .frame(width: size, height: size)
    }

    var body: some View {
        VStack(spacing: 4) {
            switch style {
            case .photo:
                imageView()
            case .video:
                ZStack{
                    imageView()
                    HStack(alignment: .center){
                        Image(systemName: "video")
                        Spacer()
                        Text(text ?? "")
                    }
                    .foregroundStyle(.labelsInverted)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background(color?.solidColor ?? .fillsSecondary)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
                
            case .audio, .more:
                Image(systemName: style == .audio ? "waveform.badge.microphone" : "photo.stack")
                    .font(.system(.body, weight: .semibold))
                if let text = text {
                    Text(text)
                }

            }
        }
        .foregroundStyle(color?.solidColor ?? .fillsSecondary)
        .frame(width: size, height: size)
        .font(.caption2)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(color?.translucentColor ?? .backgroundsTertiary)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    MemoryAttachmentItem(color: .blue, moreAmount: 10)
    MemoryAttachmentItem(color: .yellow, audioDuration: "2min")
    MemoryAttachmentItem(color: .green, photo: Image(.memoryPlaceholder))
    MemoryAttachmentItem(color: .green, preview: Image(.memoryPlaceholder), duration: "2min")
}
