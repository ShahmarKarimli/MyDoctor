//
//  HomeModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 19.02.26.
//

import Foundation

struct HomePromo: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let validityTitle: String
    let validityRange: String
    let buttonTitle: String
    let imageName: String
}

struct HomeCategory: Identifiable {
    let id = UUID()
    let iconSystemName: String
    let title: String
}

struct HomePackage: Identifiable {
    let id = UUID()
    let title: String
    let priceText: String
    let buttonTitle: String
}
