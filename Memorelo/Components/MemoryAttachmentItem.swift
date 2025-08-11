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
    var size: CGFloat

    init(color: ColorfulStyle? = nil, duration: String, size: CGFloat = 65) {
        self.color = color
        self.style = .audio
        self.text = duration
        self.size = size
    }

    init(color: ColorfulStyle? = nil, moreAmount: Int, size: CGFloat = 65) {
        self.color = color
        self.style = .more
        self.text = "+\(moreAmount)"
        self.size = size
    }

    init(color: ColorfulStyle? = nil, photo: Image, size: CGFloat = 65) {
        self.color = color
        self.style = .photo
        self.image = photo
        self.size = size
    }

    init(color: ColorfulStyle? = nil, preview: Image, duration: String, size: CGFloat = 65) {
        self.color = color
        self.style = .video
        self.image = preview
        self.text = duration
        self.size = size
    }

    init?(color: ColorfulStyle? = nil, _ attachment: MemoryAttachment, size: CGFloat = 65) {
        switch attachment.kind {
        case .photo:
            if  let url = attachment.url,
                let data = try? Data(contentsOf: url),
                let image = Image(data) {
                self.init(color: color, photo: image, size: size)
                return
            }
        case .video:
            if let previewURL = attachment.url,
               let data = try? Data(contentsOf: previewURL),
               let image = Image(data),
               let durationString = attachment.duration?.asString {
                self.init(color: color, preview: image, duration: durationString, size: size)
                return
            }
        case .audio:
            if let durationString = attachment.duration?.asString {
                self.init(color: color, duration: durationString, size: size)
                return
            }
        }

        return nil
    }

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
                ZStack {
                    imageView()
                    HStack(alignment: .center) {
                        Image(systemName: "video")
                        Spacer()
                        Text(text ?? "")
                    }
                    .foregroundStyle(.labelsInverted)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background(color?.solidColor ?? .solidPurple)
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
        .foregroundStyle(color?.solidColor ?? .solidPurple)
        .frame(width: size, height: size)
        .font(.caption2)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(color?.translucentColor ?? .translucentPurple)
        )
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    MemoryAttachmentItem(color: .blue, moreAmount: 10)
    MemoryAttachmentItem(color: .yellow, duration: "2min")
    MemoryAttachmentItem(color: .green, photo: Image(.memoryPlaceholder))
    MemoryAttachmentItem(color: .green, preview: Image(.memoryPlaceholder), duration: "2min")
}
