//
//  NetworkManager.swift
//  MyDoctor
//
//  Created by Shahmar Karimli on 31.01.26.
//

import Foundation

class NetworkManager: TokenHelper {
    
    static let shared = NetworkManager()
    
    // Lokal backend URL-i
    private let baseURL = "https://kenton-tribasic-buxomly.ngrok-free.dev"
    
    private var token: String? { retrieveToken() }
    
    private init() {
    }
    
    func request<T: Decodable>(model: NetworkRequestModel, completion: @escaping (NetworkResponse<T>) -> Void) {
        guard let urlRequest = getUrlRequest(model: model) else { return }
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            let httpResponse = response as? HTTPURLResponse
            
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                   let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                    print("--- API RESPONSE ---")
                    print(String(decoding: jsonData, as: UTF8.self))
                }
                
                do {
                    let decodedModel = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedModel))
                    }
                    return
                } catch {
                    print("Decoding Error: \(error)")
                }
            }
            
            DispatchQueue.main.async {
                let errorMsg = error?.localizedDescription ?? "Server xətası: \(httpResponse?.statusCode ?? 0)"
                completion(.error(CoreModel(
                    success: false,
                    statusCode: httpResponse?.statusCode,
                    statusMessage: errorMsg,
                    token: nil
                )))
            }
        }.resume()
    }
    
    private func getUrlRequest(model: NetworkRequestModel) -> URLRequest? {
        guard let url = URL(string: getPath(model: model)) else { return nil }
        var urlRequest = URLRequest(url: url)
        
        if let token = token {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("*/*", forHTTPHeaderField: "Accept")
        urlRequest.setValue("anything", forHTTPHeaderField: "ngrok-skip-browser-warning")
        urlRequest.httpMethod = model.method.rawValue
        urlRequest.httpBody = model.body
        
        return urlRequest
    }
    
    private func getPath(model: NetworkRequestModel) -> String {
        var path = baseURL + model.path
        
        if let pathParams = model.pathParams {
            for param in pathParams {
                path += "/\(param)"
            }
        }
        
        if let queryParams = model.queryParams, !queryParams.isEmpty {
            let query = queryParams.compactMap({
                guard let encodedValue = percentEncoding("\($0.value)") else { return nil }
                return "\($0.key)=\(encodedValue)"
            }).joined(separator: "&")
            path += "?\(query)"
        }
        
        return path
    }
    
    private func percentEncoding(_ value: String) -> String? {
        return value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
}
