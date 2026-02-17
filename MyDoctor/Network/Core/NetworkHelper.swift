//
//  NetworkHelper.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

struct NetworkRequestModel {
    let path: String
    let method: HttpMethod
    let pathParams: [Any]?
    let body: Data?
    let queryParams: [String: Any]?
    
    init(path: String, method: HttpMethod, pathParams: [Any]?, body: Data?, queryParams: [String : Any]?) {
        self.path = path
        self.method = method
        self.pathParams = pathParams
        self.body = body
        self.queryParams = queryParams
    }
    init(path: String, method: HttpMethod, pathParams: [Any]?, body: Encodable, queryParams: [String : Any]?) {
        self.path = path
        self.method = method
        self.pathParams = pathParams
        self.body = try? JSONEncoder().encode(body)
        self.queryParams = queryParams
    }
    init(path: String, method: HttpMethod, pathParams: [Any]?, body: [String: Any], queryParams: [String : Any]?) {
        self.path = path
        self.method = method
        self.pathParams = pathParams
        self.body = try? JSONSerialization.data(withJSONObject: body, options: [])
        self.queryParams = queryParams
    }
}

enum NetworkResponse<T: Decodable> {
    case success(T)
    case failure(ErrorModel)
}

/*struct CoreModel: Decodable {
    let success: Bool?
    let statusCode: Int?
    let statusMessage: String?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
    
    var errorMessage: String {
        statusMessage ?? "Local Error"
    }
}*/

struct ErrorModel: Error, Decodable {
    let timestamp: String?
    var status: Int?
    var error: String?
    let message: String?
    var path: String?
    
    var localizedDescription: String {
        error ?? message ?? "Unknown Error"
    }
}
