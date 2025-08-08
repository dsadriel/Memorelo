//
//  MemoreloDateField.swift
//  Memorelo
//
//  Created by Adriel de Souza on 08/08/25.
//

import SwiftUI

struct MemoreloDateField: View {

    var title: String
    @Binding var value: Date

    var displayedComponents: DatePicker<Label>.Components = [.hourAndMinute, .date]
    var helperText: String?
    var readOnly: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(title)
                    .font(.body)
                    .foregroundStyle(.labelsPrimary)

                DatePicker("", selection: $value, displayedComponents: displayedComponents)
                    .tint(.solidPurple)
                    .disabled(readOnly)
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
    MemoreloDateField(title: "Title", value: .constant(Date()), readOnly: true)
}
