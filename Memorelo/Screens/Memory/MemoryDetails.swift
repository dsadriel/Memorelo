//
//  MemoryDetails.swift
//  Memorelo
//
//  Created by Adriel de Souza on 11/08/25.
//

import SwiftData
import SwiftUI

struct MemoryDetails: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext

    @State var isEditMemorySheetPresented: Bool = false
    @Query var familyMembers: [MemberProfile]

    var memory: Memory

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 8) {
                    Text(memory.title)
                        .font(.system(.title, weight: .semibold))

                    Group {
                        if let firstAttachment = memory.attachments.filter({ $0.kind != .audio }).first,
                           let data = try? Data(
                            contentsOf: firstAttachment.kind == .photo ? firstAttachment.url! : firstAttachment.url!
                           ),
                           let image = Image(data) {
                            image
                                .resizable()
                        } else {
                            Image(systemName: "photo.badge.exclamationmark")
                                .font(.largeTitle)
                                .foregroundStyle(.solidPurple)
                        }
                    }
                    .scaledToFill()
                    .frame(maxWidth: .infinity, idealHeight: 245)
                    .background(.translucentPurple)
                    .clipShape(RoundedCorner(radius: 16, corners: [.topLeft, .topRight]))

                    HStack {
                        if memory.location != nil {
                            LabelWithIcon(
                                iconName: "location.fill",
                                text: memory.location ?? "Sem local",
                                color: .labelsSecondary
                            )
                        }
                        Spacer()
                        LabelWithIcon(
                            iconName: "calendar",
                            text: MemoreloApp.longDateFormatter.string(from: memory.date),
                            color: .labelsSecondary
                        )
                    }

                    FlowLayout(spacing: 4) {
                        ForEach(memory.tags, id: \.self) { tag in
                            PillLabel(text: tag)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    FlowLayout {
                        ForEach(memory.participants) { member in
                            HStack(spacing: 8) {
                                if let pictureData = member.pictureData, let image = Image(pictureData) {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 8)
                                        )
                                }

                                Text("\(Text(member.firstName).fontWeight(.semibold)) tinha \(Text(member.birthday.ageString(at: memory.date).lowercased()).fontWeight(.semibold))")
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                            .foregroundStyle(.solidPurple)
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .foregroundStyle(.translucentPurple)
                            )
                            .frame(maxWidth: 300)
                        }
                    }.frame(maxWidth: .infinity, alignment: .center)

                    if let details = memory.details, !details.isEmpty {
                        Text(details)
                    }

                    Text("TODAS RECORDAÇÕES DESTA MEMÓRIA")
                        .font(.footnote)
                        .foregroundStyle(.solidPurple)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 8)
                        .padding(.bottom, 4)

                    FlowLayout(spacing: 4) {
                        ForEach(memory.attachments) { attachment in
                            MemoryAttachmentItem(attachment, size: 85)
                        }
                    }.frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding()
            }
            .navigationTitle("Memória")
            .presentationDragIndicator(.visible)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Editar") {
                        isEditMemorySheetPresented = true
                    }
                    .foregroundStyle(.solidPurple)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Fechar") {
                        dismiss()
                    }
                    .foregroundStyle(.solidPurple)
                }
            }
            .sheet(isPresented: $isEditMemorySheetPresented) {
                EditMemory(memory: memory)
            }
        }
    }
}

#Preview {
    MemoryDetails(
        memory: Memory(
            title: "Natal de 2018",
            date: Date(),
            attachments: [],
            tags: ["Natal", "Fantasia", "Datas comemorativas"],
            location: "Shopping Lajeado",
            details:
                "Nesse dia fomos ao Shopping, assistimos um filme, João pediu um lanche na praça de alimentação e depois disso fomos tirar fotos e o João fez seu pedido de natal para o Papai Noel. Foi uma tarde incrível!",
            participants: [MemberProfile(name: "aaa", relation: "aa", birthday: Date())]
        )
    )
}
