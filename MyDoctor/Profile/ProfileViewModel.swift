//
//  ProfileViewModel.swift
//  Hekimim
//
//  Created by Nabiyev Anar on 04.02.26.
//

import Foundation
import Combine

final class ProfileViewModel: ObservableObject {
    let name = "Nurida İsmayılova"
    let info = "Qadın, 38 yaş"
    
    struct Appointment: Identifiable {
        let id = UUID()
        let date: String
        let title: String
        let subtitle: String
        let isUpcoming: Bool
    }
    
    let upcoming = Appointment(
        date: "Jan\n30",
        title: "Ginekoloq müayinəsi - Liv Bona...",
        subtitle: "Sabah,10:00, Dr.K Doğa Seçkin",
        isUpcoming: true
    )
    
    let previous: [Appointment] = [
        .init(date: "Jan\n10",
              title: "Ümumi müayinə - Liv Bona Dea",
              subtitle: "10:00, Dr.Koray Acarlı",
              isUpcoming: false),
        .init(date: "Dec\n12",
              title: "Kardioloji müayinə - Liv Bona Dea",
              subtitle: "11:00, Dr.Kadriye Kılıçkesmez",
              isUpcoming: false)
    ]
}
