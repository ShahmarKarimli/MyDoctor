//
//  SearchViewModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 21.02.26.
//

import SwiftUI

class SearchViewModel: ObservableObject {
    @Published var doctorQuery: String = "" {
        didSet {
            searchDoctors()
        }
    }
    @Published var hospitalQuery: String = "" {
        didSet {
            searchDoctors()
        }
    }
    @Published var priceRange: String = "100-150"
    
    @Published var chips: [String] = ["Kardioloq", "Ginekoloq", "Psixoloq", "Pediatr"]
    @Published var selectedChip: String? = nil
    private var isUpdatingFromChip = false
    
    @Published var doctors: [Doctor] = []
    @Published var allDoctors: [Doctor] = []
    
    let columns = [
        GridItem(.flexible(), spacing: 14),
        GridItem(.flexible(), spacing: 14)
    ]
    
    init() {
        fetchDoctors()
    }
    
    // Mock data yüklənir
    func fetchDoctors() {
        allDoctors = [
            Doctor(id: UUID(), name: "Dr. Sibel Malkoç", specialty: "Ginekoloq", hospital: "Live Bona Dea", price: 120, rating: 4.8, experience: 15, image: "doc1", isFavorite: false),
            Doctor(id: UUID(), name: "Dr. Miraç Özalp", specialty: "Ginekoloq", hospital: "Live Bona Dea", price: 130, rating: 4.9, experience: 12, image: "doc2", isFavorite: false),
            Doctor(id: UUID(), name: "Dr. K. Doğa Seçkin", specialty: "Kardioloq", hospital: "Mərkəzi Klinika", price: 150, rating: 4.7, experience: 20, image: "doc3", isFavorite: false),
            Doctor(id: UUID(), name: "Dr. Gönül Özer", specialty: "Ginekoloq", hospital: "Live Bona Dea", price: 110, rating: 4.6, experience: 10, image: "doc4", isFavorite: false),
            Doctor(id: UUID(), name: "Dr. Burak Hazine", specialty: "Psixoloq", hospital: "Şəfa Klinikası", price: 100, rating: 4.5, experience: 8, image: "doc5", isFavorite: false),
            Doctor(id: UUID(), name: "Dr. Mustafa Alper Karalök", specialty: "Pediatr", hospital: "Uşaq Sağlamlıq", price: 90, rating: 4.8, experience: 18, image: "doc6", isFavorite: false),
        ]
    }
    
    func selectChip(_ chip: String) {
        if selectedChip == chip {
            selectedChip = nil
            isUpdatingFromChip = true
            doctorQuery = ""
            isUpdatingFromChip = false
        } else {
            selectedChip = chip
            isUpdatingFromChip = true
            doctorQuery = chip
            isUpdatingFromChip = false
        }
        filterDoctors()
    }
    
    
    
    func syncChipFromQuery() {
        if !doctorQuery.isEmpty {
            if let matchingChip = chips.first(where: {
                $0.localizedCaseInsensitiveContains(doctorQuery) ||
                doctorQuery.localizedCaseInsensitiveContains($0)
            }) {
                selectedChip = matchingChip
            }
        } else {
            selectedChip = nil
        }
    }
    
    func filterDoctors() {
        var filtered = allDoctors
        
        if let specialty = selectedChip {
            filtered = filtered.filter { $0.specialty == specialty }
        }
        
        if !doctorQuery.isEmpty {
            if !isUpdatingFromChip {
                syncChipFromQuery()
            }
            
            filtered = filtered.filter { doctor in
                doctor.name.localizedCaseInsensitiveContains(doctorQuery) ||
                doctor.specialty.localizedCaseInsensitiveContains(doctorQuery)
            }
        }
        
        if !hospitalQuery.isEmpty {
            filtered = filtered.filter { doctor in
                doctor.hospital.localizedCaseInsensitiveContains(hospitalQuery)
            }
        }
        
        if !priceRange.isEmpty {
            let prices = priceRange.split(separator: "-").compactMap { Int($0) }
            if prices.count == 2 {
                let minPrice = prices[0]
                let maxPrice = prices[1]
                filtered = filtered.filter { $0.price >= minPrice && $0.price <= maxPrice }
            }
        }
        
        doctors = filtered
    }
    
    
    func searchDoctors() {
        filterDoctors()
    }
}


