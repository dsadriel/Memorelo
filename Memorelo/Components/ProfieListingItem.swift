//
//  ProfieListingItem.swift
//  Memorelo
//
//  Created by Adriel de Souza on 06/08/25.
//

import SwiftUI

struct ProfieListingItem: View {
    enum ProfileStyle {
        case user, member
    }

    var profileStyle: ProfileStyle
    var name: String
    var email: String?
    var relation: String?
    var age: String?
    var picture: Image?
    var isArchived: Bool { member != nil ? member!.isArchived : false }

    var member: MemberProfile?

    init(name: String, email: String) {
        self.profileStyle = .user
        self.name = name
        self.email = email
    }

    init(name: String, relation: String, age: String) {
        self.profileStyle = .member
        self.name = name
        self.relation = relation
        self.age = age
    }

    init(_ member: MemberProfile) {
        self.init(name: member.name, relation: member.relation, age: member.ageString)

        self.member = member

        if let data = member.pictureData, let uiImage = UIImage(data: data) {
            picture =  Image(uiImage: uiImage)
        }
    }

    var imageSize: CGFloat {
        profileStyle == .user ? 94 : 78
    }

    @State var isProfileDetailExpanded: Bool = false

    var body: some View {
        HStack(spacing: 8) {
            Group {
                if let picture {
                    picture
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: imageSize, height: imageSize)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    Image(systemName: "person.fill")
                        .frame(width: imageSize, height: imageSize)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.fillsSecondary)
                        )
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(profileStyle == .user ? .title3 : .subheadline, weight: .semibold))
                    .foregroundStyle(.labelsPrimary)

                if profileStyle == .user, let email {
                    Text(email)
                        .font(.footnote)
                        .foregroundStyle(.labelsSecondary)
                } else if let relation, let age {
                    HStack(spacing: 0) {
                        Text(relation)
                            .font(.system(.footnote, weight: .semibold))
                            .foregroundStyle(.labelsPrimary)
                        Text(" • \(age)")
                            .font(.footnote)
                            .foregroundStyle(.labelsSecondary)
                    }

                }
            }

            Spacer()

            VStack {
                Image(systemName: isArchived ? "tray.and.arrow.up.fill" : "chevron.right")
                    .font(.headline)
                    .foregroundStyle(.solidPurple)
            }
            .padding(.horizontal, 8)
        }
        .onTapGesture {
            if isArchived {
                withAnimation {
                    member?.isArchived.toggle()
                }
            } else {
                isProfileDetailExpanded.toggle()
            }
        }
        .navigationDestination(isPresented: $isProfileDetailExpanded) {
            if profileStyle == .user {
                EmptyView()
            } else {
                if let member {
                    MemberDetailsView(member: member)
                }
            }
        }
    }
}

#Preview {
    VStack {
        ProfieListingItem(name: "Adriel de Souza", email: "adriel@email.com")
        ProfieListingItem(name: "João Pedro", relation: "Sobrinho", age: "11 anos")
    }
}
