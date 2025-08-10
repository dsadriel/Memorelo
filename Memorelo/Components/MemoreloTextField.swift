//
//  MemoreloTextField.swift
//  Memorelo
//
//  Created by Adriel de Souza on 07/08/25.
//

import SwiftUI

struct MemoreloTextField: View {
    enum TextFieldStyle {
        case `default`, filled, disabled, error, readonly
    }

    @Binding var text: String

    var style: TextFieldStyle = .default
    var title: String
    var placeholder: String?
    var optionalText: String?
    var helperText: String?
    var leadingIconName: String?
    var trailingIconName: String?
    var lineLimit: ClosedRange<Int> = 1...1

    @ViewBuilder
    func trailingIcon() -> some View {
        if let trailingIconName {
            Image(systemName: trailingIconName)
        } else {
            EmptyView()
        }
    }

    @ViewBuilder
    func leadingIcon() -> some View {
        if let leadingIconName {
            Image(systemName: leadingIconName)
        } else {
            EmptyView()
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.labelsPrimary)

                if let optionalText {
                    Text(optionalText)
                        .font(.caption)
                        .foregroundStyle(.labelsSecondary)
                }

                if style == .readonly {
                    Spacer()
                    HStack( spacing: 8) {
                        leadingIcon()
                        Text(text)
                        trailingIcon()
                    }
                    .padding(.all, 8)
                    .foregroundStyle(.labelsPrimary)
                    .font(.callout)
                }
            }

            if style != .readonly {
                HStack( spacing: 8) {
                    leadingIcon()
                    TextField(placeholder ?? title, text: $text, axis: .vertical)
                        .lineLimit(lineLimit)
                        .disabled(style == .disabled || style == .readonly)
                    trailingIcon()

                }
                .foregroundStyle(style == .disabled ? .labelsTertiary : .labelsPrimary)
                .font(.callout)
                .padding(.all, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(style == .disabled ? .fillsTertiary : .backgroundsTertiary)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(style: StrokeStyle(lineWidth: 0.8))
                        .foregroundStyle(style == .error ? .colorsRed : .transparent)
                )
            }

            if let helperText {
                Text(helperText)
                    .font(.caption)
                    .foregroundStyle(style == .error ? .colorsRed : .secondary)
                    .padding(.leading, 4)
            }
        }
    }
}

#Preview("All MemoreloTextField Variants") {
    ScrollView {
        VStack(alignment: .leading, spacing: 24) {
            Group {
                // Default
                MemoreloTextField(text: .constant(""), style: .default, title: "Default Field", lineLimit: 5...10)

                // Default with placeholder
                MemoreloTextField(text: .constant(""), style: .default, title: "Field", placeholder: "Enter value")

                // Default with optional text
                MemoreloTextField(text: .constant(""), style: .default, title: "Field", optionalText: "Optional")

                // Default with icons
                MemoreloTextField(text: .constant(""), style: .default, title: "Field", leadingIconName: "person", trailingIconName: "xmark.circle")
            }

            Group {
                // Filled
                MemoreloTextField(text: .constant("Filled Text"), style: .filled, title: "Filled Field")

                // Filled with icons
                MemoreloTextField(text: .constant("Filled Text"), style: .filled, title: "Filled Field", leadingIconName: "magnifyingglass", trailingIconName: "xmark.circle")

                // Filled with helper
                MemoreloTextField(text: .constant("Data"), style: .filled, title: "Filled Field", helperText: "Helper text")
            }

            Group {
                // Disabled
                MemoreloTextField(text: .constant("Can't edit"), style: .disabled, title: "Disabled Field")

                // Disabled with icons
                MemoreloTextField(text: .constant("Icons disabled"), style: .disabled, title: "Field", leadingIconName: "lock", trailingIconName: "eye.slash")
            }

            Group {
                // Error
                MemoreloTextField(text: .constant("Wrong data"), style: .error, title: "Error Field", helperText: "This field is required")

                // Error with icons
                MemoreloTextField(text: .constant("Invalid"), style: .error, title: "Field", leadingIconName: "exclamationmark.triangle")
            }

            Group {
                // Readonly
                MemoreloTextField(text: .constant("Fixed Value"), style: .readonly, title: "Readonly Field")

                // Readonly with optional
                MemoreloTextField(text: .constant("Shown only"), style: .readonly, title: "Readonly Field", optionalText: "Autogenerated")

                // Readonly with icons
                MemoreloTextField(text: .constant("Readonly"), style: .readonly, title: "Readonly Field", leadingIconName: "house", trailingIconName: "checkmark")
            }

            Group {
                // Edge Case: Long Text
                MemoreloTextField(text: .constant("This is a very long input text meant to test wrapping or clipping."), style: .default, title: "Long Text")

                // Edge Case: Emoji
                MemoreloTextField(text: .constant("😀🥳🎉"), style: .default, title: "Emoji Field")

                // Edge Case: Empty Title and Placeholder
                MemoreloTextField(text: .constant(""), style: .default, title: "", placeholder: "")
            }
        }
        .padding()
    }
}
