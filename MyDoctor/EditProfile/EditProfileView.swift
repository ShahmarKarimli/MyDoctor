//
//  EditProfileView.swift
//  Hekimim
//
//  Created by Nabiyev Anar on 08.02.26.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = "Nurida"
    @State private var surname: String = "İsmayılova"
    @State private var phone: String = "+994556246855"

    var body: some View {
        ZStack {
            HekimimColors.background.ignoresSafeArea()

            VStack(spacing: 16) {

                EditProfileHeaderCard {
                    dismiss()
                }
                .padding(.top, -15)

                VStack(spacing: 16) {
                    InfoFieldCard(title: "Ad", value: $name)
                    InfoFieldCard(title: "Soyad", value: $surname)
                    InfoFieldCard(title: "Telefon", value: $phone, keyboard: .phonePad)

                    NavRowCard(title: "Dil") {
                        print("Language tapped")
                    }

                    NavRowCard(title: "Bildirişlər") {
                        print("Notifications tapped")
                    }
                }
                .padding(.top, 8)
                
                Spacer()

                PrimaryBottomButton(title: "Yadda saxla") {
                    
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct EditProfileHeaderCard: View {
    let onBack: () -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {

            VStack(spacing: 18) {
                avatar
                changeText
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 48)
            .padding(.bottom, 28)

            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44)
            }
            .padding(.leading, 8)
            .padding(.top, 8)
        }
        .background(HekimimColors.card)
        .cornerRadius(24)
    }

    private var avatar: some View {
        Group {
            if let uiImage = UIImage(named: "avatar") {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .padding(28)
                    .foregroundColor(.gray)
                    .background(Color.gray.opacity(0.12))
            }
        }
        .frame(width: 120, height: 120)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
        )
    }

    private var changeText: some View {
        Text("Şəkili dəyiş")
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(HekimimColors.primary)
    }
}

struct InfoFieldCard: View {
    let title: String
    @Binding var value: String
    var keyboard: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(HekimimColors.textPrimary)

            TextField("", text: $value)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(HekimimColors.textSecondary)
                .keyboardType(keyboard)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(HekimimColors.card)
        .cornerRadius(16)
    }
}

struct NavRowCard: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(HekimimColors.textPrimary)

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(HekimimColors.textSecondary.opacity(0.8))
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12.5)
            .background(HekimimColors.card)
            .cornerRadius(16)
        }
    }
}

#Preview {
    EditProfileView()
}
