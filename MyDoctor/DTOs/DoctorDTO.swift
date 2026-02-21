//
//  DoctorDTO.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 21.02.26.
//
import Foundation

struct Doctor: Identifiable {
    let id: UUID
    let name: String
    let specialty: String
    let hospital: String
    let price: Int
    let rating: Double
    let experience: Int
    let image: String
    var isFavorite: Bool
}


