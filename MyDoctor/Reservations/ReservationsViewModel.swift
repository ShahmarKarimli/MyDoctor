//
//  ReservationsViewModel.swift
//  Hekimim
//
//  Created by Nabiyev Anar on 08.02.26.
//

import SwiftUI
import Combine

final class ReservationsViewModel: ObservableObject {
    
    let upcomingTitle = "Növbəti həkim qəbulu"
    let previousTitle = "Öncəki rezervasiyalarım"
    
    let upcoming: ReservationItem = .init(
        title: "Ginekoloq müayinəsi",
        hospital: "Liv Bona Dea",
        doctor: "Dr.K Doğa Seçkin",
        date: "30.01.2026",
        time: "10:00",
        buttonTitle: "Qəbzi yüklə"
    )
    
    let previous: [ReservationItem] = [
        .init(
            title: "Ümumi müayinə",
            hospital: "Liv Bona Dea",
            doctor: "Dr.Koray Acarlı",
            date: "10.01.2026",
            time: "10:00",
            buttonTitle: "Reseptə bax"
        ),
        .init(
            title: "Kardioloji müayinə",
            hospital: "Liv Bona Dea",
            doctor: "Dr.Kadriye Kılıçkesmez",
            date: "12.12.2025",
            time: "11:00",
            buttonTitle: "Reseptə bax"
        ),
        .init(
            title: "Stomatologiya",
            hospital: "Liv Bona Dea",
            doctor: "Dr.Melisa Albayrak",
            date: "15.11.2025",
            time: "13:00",
            buttonTitle: "Reseptə bax"
        )
    ]
}
