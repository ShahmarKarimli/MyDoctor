//
//  OTPModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 01.02.26.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let verifyOtpRequestModel = try? JSONDecoder().decode(VerifyOtpRequestModel.self, from: jsonData)

import Foundation

// MARK: - VerifyOtpRequestModel
struct VerifyOtpRequestModel: Codable {
    let email: String?
    let code: String?

    enum CodingKeys: String, CodingKey {
        case email = "email"
        case code = "code"
    }
}
