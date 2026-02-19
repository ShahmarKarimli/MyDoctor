//
//  ReservationItem.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 19.02.26.
//

import Foundation

struct ReservationItem: Identifiable {
    let id = UUID()
    let title: String
    let hospital: String
    let doctor: String
    let date: String
    let time: String
    let buttonTitle: String
}
