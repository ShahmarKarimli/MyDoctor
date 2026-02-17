//
//  TokenDTO.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 16.02.26.
//

struct TokenDTO: Decodable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "token"
    }
    
}
