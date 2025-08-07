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

    var imageSize: CGFloat {
        profileStyle == .user ? 94 : 78
    }
    
    @State var isProfileDetailExpanded: Bool = false

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "person.fill")
                .frame(width: imageSize, height: imageSize)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundStyle(Color.SystemColors.fillsSecondary)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.system(profileStyle == .user ? .title3 : .subheadline, weight: .semibold))
                    .foregroundStyle(Color.SystemColors.labelsPrimary)

                if profileStyle == .user, let email {
                    Text(email)
                        .font(.footnote)
                        .foregroundStyle(Color.SystemColors.labelsSecondary)
                } else if let relation, let age {
                    HStack(spacing: 0) {
                        Text(relation)
                            .font(.system(.footnote, weight: .semibold))
                            .foregroundStyle(Color.SystemColors.labelsPrimary)
                        Text(" • \(age)")
                            .font(.footnote)
                            .foregroundStyle(Color.SystemColors.labelsSecondary)
                    }

                }
            }

            Spacer()

            VStack {
                Image(systemName: "chevron.right")
                    .font(.headline)
                    .foregroundStyle(.solidPurple)
            }
            .padding(.horizontal, 8)
        }
        .onTapGesture {
            isProfileDetailExpanded.toggle()
        }
        .sheet(isPresented: $isProfileDetailExpanded){
            EmptyView()
        }
    }
}

#Preview {
    VStack {
        ProfieListingItem(name: "Adriel de Souza", email: "adriel@email.com")
        ProfieListingItem(name: "João Pedro", relation: "Sobrinho", age: "11 anos")
    }
}
