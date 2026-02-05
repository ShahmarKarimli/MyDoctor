//
//  RegisterRequestModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 01.02.26.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let registerRequestModel = try? JSONDecoder().decode(RegisterRequestModel.self, from: jsonData)

import Foundation

// MARK: - RegisterRequestModel
struct RegisterRequestModel: Codable {
    let firstname: String?
    let lastname: String?
    let email: String?
    let password: String?
    let phoneNumber: String?
    let role: String?

    enum CodingKeys: String, CodingKey {
        case firstname = "firstname"
        case lastname = "lastname"
        case email = "email"
        case password = "password"
        case phoneNumber = "phoneNumber"
        case role = "role"
    }
}
