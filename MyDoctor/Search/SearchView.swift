//
//  SearchView.swift
//  Hekimim
//
//  Created by Nabiyev Anar on 16.02.26.
//

import SwiftUI

struct SearchView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var doctorQuery: String = ""
    @State private var hospitalQuery: String = ""
    
    let chips = ["Kardioloq", "Ginekoloq", "Psixoloq", "Pediatr"]
    
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
                        text: $doctorQuery,
                        placeholder: "Həkim/ ixtisas üzrə axtar",
                        rightIcon: "magnifyingglass",
                        rightIconType: .search) {
                            print("search doctor")
                        }
                    
                    HStack(spacing: 10) {
                        SearchField(
                            text: $hospitalQuery,
                            placeholder: "Xəstəxana adı",
                            rightIcon: "magnifyingglass",
                            rightIconType: .search) {
                                print("search hospital")
                            }
                        
                        FilterButton(title: "Qiymət") {
                            print("price filter")
                        }
                        .frame(width: 130)
                    }
                    
                    ChipsRow(items: chips) { item in
                        print("chip:", item)
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
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

#Preview {
    SearchView()
}
