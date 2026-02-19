//
//  ProfileView.swift
//  Hekimim
//
//  Created by Nabiyev Anar on 04.02.26.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
    
    @State private var showEditProfile = false
    @State private var goToReservations = false
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            HekimimColors.background.ignoresSafeArea()
            
            VStack(spacing: 14) {
                
                TopBar(
                    onBack: { dismiss() },
                    onEdit: { showEditProfile = true }
                )
                .padding(.top, 6)
                .padding(.horizontal, 20)
                .background(Color.white)
                
                ProfileHeader(vm: vm)
                    .padding(.top, -20)
                
                SectionHeader(
                    title: "Növbəti həkim qəbulu",
                    action: "Hamısına bax",
                    onTapAction: { goToReservations = true }
                )
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                UpcomingCard(appointment: vm.upcoming)

                SectionHeader(
                    title: "Öncəki rezervasiyalarım",
                    action: "Hamısına bax",
                    onTapAction: { goToReservations = true }
                )
                .padding(.top, 10)
                .padding(.horizontal, 20)
                
                PreviousListCard(items: vm.previous)

                Spacer(minLength: 0)
                
                PrimaryBottomButton(title: "Yeni rezervasiya") {
                    print("new reservation")
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 20)
                
                NavigationLink(
                    destination: ReservationsView().navigationBarBackButtonHidden(true), isActive: $goToReservations
                ) { EmptyView() }
                    .hidden()
            }
            .padding(0)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationDestination(isPresented: $showEditProfile) {
            EditProfileView()
                .navigationBarBackButtonHidden(true)
        }
    }
}

struct TopBar: View {
    let onBack: () -> Void
    let onEdit: () -> Void

    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44, alignment: .leading)
            }

            Spacer()

            Button(action: onEdit) {
                Text("Redaktə et")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(HekimimColors.primary)
                    .frame(height: 44)
            }
            .frame(width: 110, alignment: .trailing)
        }
    }
}

struct ProfileHeader: View {
    let vm: ProfileViewModel

    var body: some View {
        VStack(spacing: 10) {

            Group {
                if let uiImage = UIImage(named: "avatar") {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .scaledToFit()
                        .padding(22)
                        .foregroundColor(.gray)
                        .background(Color.gray.opacity(0.12))
                }
            }
            .frame(width: 88, height: 88)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray.opacity(0.25), lineWidth: 1))

            Text(vm.name)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(HekimimColors.textPrimary)

            Text(vm.info)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(HekimimColors.textSecondary)
            
            Button {
                
            } label: {
                Text("Aktiv hesab")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(HekimimColors.primary)
                    .padding(.horizontal, 26)
                    .padding(.vertical, 12)
            }
            .background(HekimimColors.lightButtonFill)
            .cornerRadius(12)
        }
        .padding(.vertical, 22)
        .frame(maxWidth: .infinity)
        .background(HekimimColors.card)
        .cornerRadius(20)
    }
}

struct SectionHeader: View {
    let title: String
    let action: String
    let onTapAction: () -> Void
    
    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
            
            Spacer()
            
            Button(action: onTapAction) {
                Text(action)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(HekimimColors.primary)
            }
        }
        .padding(.top, 2)
    }
}

struct DateBadge: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .semibold))
            .foregroundColor(HekimimColors.primary)
            .multilineTextAlignment(.center)
            .frame(width: 44, height: 44)
            .background(HekimimColors.badgeFill)
            .clipShape(Circle())
    }
}

struct UpcomingCard: View {
    let appointment: ProfileViewModel.Appointment

    var body: some View {
        VStack(spacing: 12) {
            HStack(alignment: .top, spacing: 12) {
                DateBadge(text: appointment.date)

                VStack(alignment: .leading, spacing: 6) {
                    Text(appointment.title)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .lineLimit(2)

                    Text(appointment.subtitle)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(HekimimColors.textSecondary)
                        .lineLimit(1)
                }

                Spacer()

                Image(systemName: "bell")
                    .font(.system(size: 20, weight: .regular))
                    .foregroundColor(HekimimColors.primary)
                    .padding(.top, 4)
            }

            HStack(spacing: 14) {
                GrayButton(title: "Tarixi dəyiş") { print("change date") }
                LightOutlineButton(title: "Təsdiq et") { print("confirm") }
            }
        }
        .padding(16)
        .background(HekimimColors.card)
        .cornerRadius(18)
    }
}

struct PreviousListCard: View {
    let items: [ProfileViewModel.Appointment]

    var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                PreviousRow(item: item)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)

                if index != items.count - 1 {
                    Divider()
                        .background(HekimimColors.divider)
                        .padding(.leading, 76)
                }
            }
        }
        .background(HekimimColors.card)
        .cornerRadius(18)
    }
}

struct PreviousRow: View {
    let item: ProfileViewModel.Appointment

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            DateBadge(text: item.date)

            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .lineLimit(2)

                Text(item.subtitle)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(HekimimColors.textSecondary)
            }

            Spacer()

            Image(systemName: "clock.arrow.circlepath")
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(HekimimColors.iconGray)
                .padding(.top, 4)
        }
    }
}

struct GrayButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(HekimimColors.grayButtonText)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(HekimimColors.grayButton)
                .cornerRadius(12)
        }
    }
}

struct LightOutlineButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(HekimimColors.primary)
                .frame(maxWidth: .infinity, minHeight: 44)
                .background(HekimimColors.lightButtonFill)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(HekimimColors.lightButtonBorder, lineWidth: 1)
                )
        }
    }
}

struct PrimaryBottomButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 56)
                .background(HekimimColors.primary)
                .cornerRadius(8)
        }
    }
}

#Preview {
    ProfileView()
}

