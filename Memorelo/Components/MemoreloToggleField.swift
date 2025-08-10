//
//  MemoreloToggleField.swift
//  Memorelo
//
//  Created by Adriel de Souza on 08/08/25.
//

import SwiftUI

struct MemoreloToggleField: View {

    var title: String
    @Binding var value: Bool

    var helperText: String?
    var readOnly: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.labelsPrimary)

                Toggle("", isOn: $value)
                    .disabled(readOnly)
                    .tint(.solidPurple)
            }

            if let helperText {
                Text(helperText)
                    .font(.caption)
                    .foregroundStyle(.labelsSecondary)
                    .padding(.leading, 4)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

}

#Preview {
    MemoreloToggleField(title: "Title", value: .constant(false))
    MemoreloToggleField(title: "Title", value: .constant(true))
}
