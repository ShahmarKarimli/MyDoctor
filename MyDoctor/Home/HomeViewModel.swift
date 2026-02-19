//
//  HomeViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 19.02.26.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var selectedTab: HomeTab = .analizler
    @Published var promoIndex: Int = 0

    enum HomeTab: String, CaseIterable, Identifiable {
        case analizler = "Analizlər"
        case checkup = "Check up paketləri"
        var id: String { rawValue }
    }

    let promos: [HomePromo] = [
        .init(
            title: "Bütün onkomarkerlərə\n20% ENDİRİM !",
            description: "Xərçəng xəstəliyi çox vaxt ilkin mərhələdə heç bir əlamət göstərməsə də, bu onkomarkerlər xəstəliyin hələ simptomsuz dövründə riski təyin etmək üçün olduqca əhəmiyyətlidir.",
            validityTitle: "ETİBARLILIQ MÜDDƏTİ",
            validityRange: "04.02.2026 - 28.02.2026",
            buttonTitle: "Xidmətə yazıl",
            imageName: "promo_cancer"
        ),
        .init(
            title: "Check-up paketlərdə\nYeni endirimlər",
            description: "Sağlamlığınız üçün ən uyğun paketləri seçin və vaxtında müayinə olun.",
            validityTitle: "ETİBARLILIQ MÜDDƏTİ",
            validityRange: "01.03.2026 - 31.03.2026",
            buttonTitle: "Xidmətə yazıl",
            imageName: "promo_checkup"
        )
    ]

    let categories: [HomeCategory] = [
        .init(iconSystemName: "doc.text.magnifyingglass", title: "Laboratoriya\nxidmətləri"),
        .init(iconSystemName: "heart.text.square", title: "Kardiologiya\nxidmətləri"),
        .init(iconSystemName: "brain.head.profile", title: "Psixoterapiya\nxidmətləri")
    ]

    let packagesAnalizler: [HomePackage] = [
        .init(title: "Poliklinik Check Up geniş (kişi)", priceText: "690 AZN", buttonTitle: "Ətraflı məlumat"),
        .init(title: "Poliklinik Check Up geniş (qadın)", priceText: "529 AZN", buttonTitle: "Ətraflı məlumat")
    ]

    let packagesCheckup: [HomePackage] = [
        .init(title: "Kardioloji paket (standart)", priceText: "299 AZN", buttonTitle: "Ətraflı məlumat"),
        .init(title: "Ümumi Check Up (premium)", priceText: "799 AZN", buttonTitle: "Ətraflı məlumat")
    ]
}
