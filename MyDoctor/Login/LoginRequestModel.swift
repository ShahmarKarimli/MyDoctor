//
//  LoginRequestModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 02.02.26.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let loginRequestModel = try? JSONDecoder().decode(LoginRequestModel.self, from: jsonData)

import Foundation

// MARK: - LoginRequestModel
struct LoginRequestModel: Codable {
    let email: String?
    let password: String?

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case password = "password"
    }
}
