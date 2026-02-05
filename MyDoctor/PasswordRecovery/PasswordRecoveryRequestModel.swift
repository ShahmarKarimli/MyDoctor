//
//  PasswordRecoveryRequestModel.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 02.02.26.
//

struct ForgotPasswordRequestModel: Codable {
    let email: String?
    
    enum CodingKeys: String, CodingKey {
           case email = "email"
       }
}
