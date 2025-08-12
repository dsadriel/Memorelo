//
//  SelectParticipants.swift
//  Memorelo
//
//  Created by Adriel de Souza on 11/08/25.
//

import SwiftData
import SwiftUI

struct SelectParticipants: View {

    @Query(filter: #Predicate<MemberProfile> { !$0.isArchived }) var members: [MemberProfile]

    @Binding var selectedMembers: [MemberProfile]
    @State private var sheetContentHeight: CGFloat = 0

    var body: some View {
        FlowLayout {
            ForEach(members) { member in
                let selected = selectedMembers.contains(where: { $0.id == member.id })
                VStack(spacing: 8) {
                    if let pictureData = member.pictureData, let image = Image(pictureData) {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 85, height: 85)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 8)
                            )
                    }

                    Text(member.firstName)
                        .font(.headline)
                }
                .foregroundStyle(selected ? .labelsInverted : .solidPurple)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(selected ? .solidPurple : .translucentPurple)
                )
                .onTapGesture {
                    if selected {
                        selectedMembers.removeAll(where: { $0.id == member.id })
                    } else {
                        selectedMembers.append(member)
                    }
                }
                .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: selectedMembers)
            }
        }
        .padding(24)
        .background {
            GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        sheetContentHeight = proxy.size.height
                    }
                    .onChange(of: proxy.size.height) { _, newHeight in
                        sheetContentHeight = newHeight
                    }
            }
        }

        .presentationDetents([.height(sheetContentHeight)])
        .presentationDragIndicator(.visible)

    }
}

#Preview {
    SelectParticipants(selectedMembers: .constant([]))
}
