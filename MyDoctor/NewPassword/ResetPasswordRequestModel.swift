//
//  ResetPasswordRequestModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 04.02.26.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let resetPasswordRequestModel = try? JSONDecoder().decode(ResetPasswordRequestModel.self, from: jsonData)

import Foundation

// MARK: - ResetPasswordRequestModel
struct ResetPasswordRequestModel: Codable {
    let email: String?
    let otp: String?
    let newPassword: String?

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case otp = "otp"
        case newPassword = "newPassword"
    }
}

struct EmailRequestModel: Encodable {
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case email = "email"
    }
}
