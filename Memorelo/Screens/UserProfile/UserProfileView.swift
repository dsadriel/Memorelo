//
//  UserProfileView.swift
//  Memorelo
//
//  Created by Adriel de Souza on 08/08/25.
//

import SwiftData
import SwiftUI

struct UserProfileView: View {
    @Environment(\.dismiss) var dismiss

    @Query var users: [UserProfile]
    var user: UserProfile {
        guard let user = users.first else {
            dismiss()
            return UserProfile(name: "", email: "")
        }
        return user
    }

    var profilePicture: Image? {
        if let data = user.pictureData {
            return Image(data)
        }
        return nil
    }

    @State var isEditUserSheetPresented: Bool = false
    @State var remindersEnabled: Bool = false
    @State var reminder: Date = Date()

    var body: some View {
        ScrollView {
            VStack(spacing: 8) {

                if let profilePicture {
                    profilePicture
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    Image(systemName: "person.fill")
                        .frame(width: 150, height: 150)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(.fillsSecondary)
                        )
                }

                Text(user.name)
                    .font(.system(.title, weight: .bold))
                    .foregroundStyle(.labelsPrimary)

                Rectangle()
                    .frame(height: 16)
                    .foregroundStyle(.transparent)

                Text("DADOS PESSOAIS")
                    .font(.footnote)
                    .foregroundStyle(.labelsSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 7)

                MemoreloTextField(text: .constant(user.email), style: .readonly, title: "Email")

                if let birthday = user.birthday {
                    MemoreloDateField(
                        title: "Data de Nascimento",
                        value: .constant(birthday),
                        displayedComponents: [.date],
                        readOnly: true
                    )
                } else {
                    MemoreloTextField(
                        text: .constant("Não informado"),
                        style: .readonly,
                        title: "Data de Nascimento"
                    )
                }

                Rectangle().frame(height: 8).foregroundStyle(.transparent)

                Text("LEMBRETES")
                    .font(.footnote)
                    .foregroundStyle(.labelsSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 7)

                MemoreloToggleField(title: "Ativar notificações", value: $remindersEnabled)
                    .onChange(of: remindersEnabled) {
                        user.isNotificationEnabled = remindersEnabled
                    }

                MemoreloDateField(
                    title: "Lembrar todo dia às",
                    value: $reminder,
                    displayedComponents: [.hourAndMinute],
                )
                .onChange(of: reminder) {
                    let calendar = Calendar.current
                    let components = calendar.dateComponents([.hour, .minute], from: reminder)

                    if let hour = components.hour, let minute = components.minute {
                        user.notificationTime = Time(hour: hour, minute: minute)
                    }
                }

                Rectangle()
                    .frame(height: 32)
                    .foregroundStyle(.transparent)

                MemoreloButton(text: "Sair da conta", style: .primary) {}
            }
        }
        .onAppear {
            let calendar = Calendar.current
            if let reminderDate = calendar.date(
                from: DateComponents(hour: user.notificationTime.hour, minute: user.notificationTime.minute)
            ) {
                reminder = reminderDate
            }

            remindersEnabled = user.isNotificationEnabled
        }
        .padding()
        .scrollClipDisabled(true)
        .navigationTitle("Seu perfil")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    isEditUserSheetPresented = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .fontWeight(.bold)
                        .foregroundStyle(.solidPurple)
                }
            }
        }
        .sheet(isPresented: $isEditUserSheetPresented) {
            EditUserView()
        }
    }

}
#Preview {
    NavigationStack {
        UserProfileView()
    }
}
