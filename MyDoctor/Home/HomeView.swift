//
//  MainView.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 17.02.26.
//

import SwiftUI


struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    
    @State private var goToProfile = false
    @State private var goToSearch = false
    
    var body: some View {
        ZStack {
            HekimimColors.background.ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    
                    HomeTopBar(
                        searchText: $vm.searchText,
                        onMenu: { print("menu") },
                        onSearch: { goToSearch = true },
                        onProfile: { goToProfile = true }
                    )
                    .padding(.top, 8)
                    .padding(.horizontal, 20)
                    
                    PromoCarousel(
                        promos: vm.promos,
                        onPrimaryAction: { print("promo action") },
                        index: $vm.promoIndex
                    )
                    
                    CategoriesRow(categories: vm.categories) { cat in
                        print("tap category:", cat.title)
                    }
                    .padding(.horizontal, 20)
                    
                    QuoteCard(text: "Əldə etdiyiniz nəticələr sadəcə rəqəm deyil ,\nsağlamlığınızın göstəricəsidir !")
                        .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ən çox axtarılanlar")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                        
                        HomeSegmentedControl(
                            tabs: HomeViewModel.HomeTab.allCases,
                            selection: $vm.selectedTab
                        )
                        
                        PackagesRow(packages: currentPackages(vm: vm)) { pkg in
                            print("tap package:", pkg.title)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer().frame(height: 10)
                    
                    NavigationLink(
                        destination: ProfileView().navigationBarBackButtonHidden(true),
                        isActive: $goToProfile
                    ) { EmptyView() }
                        .hidden()
                     NavigationLink(
                        destination: SearchView().navigationBarBackButtonHidden(true),
                        isActive: $goToSearch) {
                            EmptyView()
                        }
                        .hidden()
                }
                .padding(.bottom, 20)
            }
        }
    }
    
    private func currentPackages(vm: HomeViewModel) -> [HomePackage] {
        vm.selectedTab == .analizler ? vm.packagesAnalizler : vm.packagesCheckup
    }
}

struct HomeTopBar: View {
    @Binding var searchText: String
    let onMenu: () -> ()
    let onSearch: () -> ()
    let onProfile: () -> ()
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: onMenu) {
                Image("3line")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
            }
            
            SearchBar(text: $searchText, onSearch: onSearch)
                .frame(height: 42)
            
            Button(action: onProfile) {
                Image("person")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(.black)
                    .frame(width: 24, height: 24)
            }
        }
    }
}

struct SearchBar: View {
    @Binding var text: String
    let onSearch: () -> ()
    
    var body: some View {
        HStack(spacing: 10) {
            TextField("Axtarış", text: $text)
                .font(.system(size: 14, weight: .medium))
            
            Button(action: onSearch) {
                Image("glass")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(HekimimColors.primary)
                    .frame(width: 36, height: 36)
            }
        }
        .padding(.horizontal, 14)
        .background(HekimimColors.card)
        .cornerRadius(10)
    }
}

struct PromoCarousel: View {
    let promos: [HomePromo]
    let onPrimaryAction: () -> ()
    @Binding var index: Int
    
    var body: some View {
        VStack(spacing: 10) {
            TabView(selection: $index) {
                ForEach(Array(promos.enumerated()), id: \.offset) { i, item in
                    PromoCard(promo: item, onPrimaryAction: onPrimaryAction)
                        .tag(i)
                }
            }
            .frame(height: 220)
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            PageDots(count: promos.count, index: index)
        }
    }
}

struct PageDots: View {
    let count: Int
    let index: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { i in
                Circle()
                    .fill(i == index ? HekimimColors.textSecondary.opacity(0.6) : HekimimColors.textSecondary.opacity(0.25))
                    .frame(width: 6, height: 6)
            }
        }
        .padding(.top, 2)
    }
}

struct PromoCard: View {
    let promo: HomePromo
    let onPrimaryAction: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack(alignment: .topLeading) {
                if let uiImage = UIImage(named: promo.imageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image("mikrob")
                }
                
                Text(promo.title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(12)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 168, height: 168)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(promo.description)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(HekimimColors.textSecondary)
                
                Text(promo.validityTitle)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.black)
                    .padding(.top, 2)
                
                Rectangle()
                    .fill(HekimimColors.secondaryButton)
                    .frame(height: 29)
                    .cornerRadius(8)
                    .overlay(
                        Text(promo.validityRange)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.white)
                    )
                
                Button(action: onPrimaryAction) {
                    Text(promo.buttonTitle)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 31)
                        .background(HekimimColors.primary)
                        .cornerRadius(8)
                }
            }
        }
        .padding(14)
        .background(HekimimColors.card)
        .cornerRadius(8)
    }
}

struct CategoriesRow: View {
    let categories: [HomeCategory]
    let onTap: (HomeCategory) -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(categories) { item in
                CategoryCard(category: item) {
                    onTap(item)
                }
            }
        }
    }
}

struct CategoryCard: View {
    let category: HomeCategory
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: category.iconSystemName)
                    .font(.system(size: 28, weight: .regular))
                    .foregroundColor(HekimimColors.primary)
                    .frame(width: 36, height: 36)
                
                Text(category.title)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(HekimimColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(HekimimColors.card)
            .cornerRadius(8)
        }
    }
}

struct QuoteCard: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .regular))
            .foregroundColor(HekimimColors.textSecondary)
            .multilineTextAlignment(.center)
            .padding(.vertical, 22)
            .frame(maxWidth: .infinity)
            .background(HekimimColors.card)
            .cornerRadius(18)
    }
}

struct HomeSegmentedControl<T: CaseIterable & Identifiable & RawRepresentable>: View where T.RawValue == String {
    let tabs: [T]
    @Binding var selection: T
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                Button {
                    selection = tab
                } label: {
                    Text(tab.rawValue)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(selection.id == tab.id ? .white : .black)
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .background(selection.id == tab.id ? HekimimColors.primary : Color.clear)
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .stroke(HekimimColors.primary, lineWidth: 2)
        )
        .cornerRadius(16)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct PackagesRow: View {
    let packages: [HomePackage]
    let onTap: (HomePackage) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 14) {
                ForEach(packages) { item in
                    PackageCard(package: item) { onTap(item) }
                        .frame(width: 260)
                }
            }
            .padding(.vertical, 2)
        }
    }
}

struct PackageCard: View {
    let package: HomePackage
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(package.title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
            
            Text(package.priceText)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.black)
            
            Button(action: action) {
                Text(package.buttonTitle)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 33)
                    .background(HekimimColors.primary)
                    .cornerRadius(8)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(HekimimColors.primary.opacity(0.65))
        )
    }
}

