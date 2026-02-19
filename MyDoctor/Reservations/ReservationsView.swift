//
//  ReservationsView.swift
//  Hekimim
//
//  Created by Nabiyev Anar on 08.02.26.
//

import SwiftUI

struct ReservationsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = ReservationsViewModel()
    
    var body: some View {
        ZStack {
            HekimimColors.background.ignoresSafeArea()
            
            VStack(spacing: 12) {
                
                ReservationsTopBar(
                    title: "Rezervasiyalarım",
                    onBack: { dismiss() }
                )
                .padding(.top, 6)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 12) {
                        
                        Text(vm.upcomingTitle)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(HekimimColors.textSecondary)
                            .padding(.horizontal, 20)
                            
                        ReservationCard(item: vm.upcoming) {
                            
                        }
                        
                        Text(vm.previousTitle)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(HekimimColors.textSecondary)
                            .padding(.horizontal, 20)
                            .padding(.top, 5)
                        
                        VStack(spacing: 14) {
                            ForEach(vm.previous) { item in
                                ReservationCard(item: item) {
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }
}

struct ReservationsTopBar: View {
    let title: String
    let onBack: () -> ()
    
    var body: some View {
        HStack {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 44, height: 44, alignment: .leading)
            }
            
            Spacer()
            
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
            
            Spacer()
            
            Color.clear
                .frame(width: 44, height: 44)
        }
        .padding(.horizontal, 16)
    }
}

struct ReservationCard: View {
    let item: ReservationItem
    let action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            Text(item.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(HekimimColors.primary)
            
            Divider()
                .background(HekimimColors.divider)
            
            ReservationInfoRow(label: "Xəstəxana:", value: item.hospital)
            ReservationInfoRow(label: "Həkim:", value: item.doctor)
            ReservationInfoRow(label: "Tarix:", value: item.date)
            ReservationInfoRow(label: "Saat:", value: item.time)
            
            PrimaryBottomButton(title: item.buttonTitle, action: action)
                .frame(height: 48)
        }
        .padding(16)
        .background(HekimimColors.card)
        .cornerRadius(8)
    }
}

struct ReservationInfoRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 6) {
            Text(label)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
            
            Text(value)
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.black)
            
            Spacer()
        }
    }
}


#Preview {
    ReservationsView()
}
