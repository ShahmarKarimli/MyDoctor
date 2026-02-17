//
//  MessageDTO.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 16.02.26.
//

struct MessageDTO: Decodable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
