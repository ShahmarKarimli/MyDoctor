//
//  SearchView.swift
//  Hekimim
//
//  Created by Nabiyev Anar on 16.02.26.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = SearchViewModel()
    
    var body: some View {
        ZStack {
            HekimimColors.background.ignoresSafeArea()
            
            VStack(spacing: 14) {
                SearchTopBar(title: "Axtarış") {
                    dismiss()
                }
                .padding(.top, 6)
                
                VStack(spacing: 12) {
                    SearchField(
                        text: $vm.doctorQuery,
                        placeholder: "Həkim/ ixtisas üzrə axtar",
                        rightIcon: "magnifyingglass",
                        rightIconType: .search) {
                            vm.searchDoctors()
                        }
                    
                    HStack(spacing: 10) {
                        SearchField(
                            text: $vm.hospitalQuery,
                            placeholder: "Xəstəxana adı",
                            rightIcon: "magnifyingglass",
                            rightIconType: .search) {
                                vm.searchDoctors()
                            }
                        
                        FilterButton(title: vm.priceRange) {
                            print("price filter")
                        }
                        .frame(width: 130)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(vm.chips, id: \.self) { item in
                                Button {
                                    vm.selectChip(item)
                                } label: {
                                    Text(item)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(vm.selectedChip == item ? .white : HekimimColors.textSecondary)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(vm.selectedChip == item ? HekimimColors.primary : HekimimColors.card)
                                        .cornerRadius(12)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                ScrollView(showsIndicators: false) {
                    if vm.selectedChip != nil || !vm.doctorQuery.isEmpty || !vm.hospitalQuery.isEmpty {
                        if vm.doctors.isEmpty {
                            VStack(spacing: 16) {
                                Spacer().frame(height: 100)
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 60))
                                    .foregroundColor(HekimimColors.textSecondary.opacity(0.3))
                                Text("Nəticə tapılmadı")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(HekimimColors.textSecondary)
                            }
                            .frame(maxWidth: .infinity)
                        } else {
                            LazyVGrid(columns: vm.columns, spacing: 14) {
                                ForEach(vm.doctors) { doctor in
                                    DoctorGridCard(doctor: doctor)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                        }
                    } else {
                        VStack(spacing: 16) {
                            Spacer().frame(height: 100)
                            Image(systemName: "stethoscope")
                                .font(.system(size: 60))
                                .foregroundColor(HekimimColors.primary.opacity(0.3))
                            Text("İxtisas seçin və ya axtarış edin")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(HekimimColors.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SearchTopBar: View {
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
            
            Color.clear.frame(width: 44, height: 44)
        }
        .padding(.horizontal, 20)
    }
}

struct SearchField: View {
    enum RightIconType { case search, filter }
    
    @Binding var text: String
    
    let placeholder: String
    let rightIcon: String
    let rightIconType: RightIconType
    let onRightTap: () -> ()
    
    var body: some View {
        HStack(spacing: 10) {
            TextField(placeholder, text: $text)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
            
            Button(action: onRightTap) {
                Image(systemName: rightIcon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(HekimimColors.primary)
                    .frame(width: 36, height: 36)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 42)
        .background(HekimimColors.card)
        .cornerRadius(8)
    }
}

struct FilterButton: View {
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(HekimimColors.textSecondary)
                
                Spacer()
                
                Image(systemName: "slider.horizontal.3")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(HekimimColors.primary)
            }
            .padding(.horizontal, 20)
            .frame(height: 42)
            .background(HekimimColors.card)
            .cornerRadius(8)
        }
    }
}

struct ChipsRow: View {
    let items: [String]
    let onTap: (String) -> ()
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(items, id: \.self) { item in
                Button {
                    onTap(item)
                } label: {
                    Text(item)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(HekimimColors.textSecondary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 8.5)
                        .background(HekimimColors.card)
                        .cornerRadius(12)
                }
            }
        }
    }
}

struct DoctorGridCard: View {
    let doctor: Doctor
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(doctor.image)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            
            VStack {
                HStack {
                    Text(doctor.name)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.leading, 12)
                        .padding(.top, 12)
                    
                    Spacer()
                    
                    Button {
                    } label: {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .padding(.trailing, 12)
                            .padding(.top, 12)
                    }
                }
                Spacer()
            }
            
            
            Button {
            } label: {
                Text("Hekimə yazıl")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(HekimimColors.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .frame(height: 200)
        .background(HekimimColors.imageBackground)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    SearchView()
}
