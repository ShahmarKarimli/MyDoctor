import Foundation

class NetworkManager: TokenHelper {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://kenton-tribasic-buxomly.ngrok-free.dev"
    
    private var token: String? { retrieveToken() }
    
    private init() {}
    
    func request<T: Decodable>(model: NetworkRequestModel, completion: @escaping (NetworkResponse<T>) -> Void) {
        guard let urlRequest = getUrlRequest(model: model) else { return }
        
        let completion = { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
        URLSession.shared.dataTask(with: urlRequest) {
            data, response, error in
            
            if let data {
                print(String(data: data, encoding: .utf8) as Any)
                if let dto = try? JSONDecoder().decode(T.self, from: data) {
                    if let messageDTO = dto as? MessageDTO, let statusCode = (response as? HTTPURLResponse)?.statusCode {
                        if (200...299).contains(statusCode) {
                            completion(.success(dto))
                            return
                        }
                        completion(.failure(ErrorModel(
                            timestamp: nil,
                            status: statusCode,
                            error: messageDTO.message,
                            message: messageDTO.message,
                            path: model.path)))
                        return
                    }
                    completion(.success(dto))
                    return
                } else if var dto = try? JSONDecoder().decode(ErrorModel.self, from: data) {
                    if dto.status == nil {
                        dto.status = (response as? HTTPURLResponse)?.statusCode
                    }
                    if dto.path == nil {
                        dto.path = model.path
                    }
                    completion(.failure(dto))
                    return
                }
            }
            
            let dto = ErrorModel(
                timestamp: nil,
                status: (response as? HTTPURLResponse)?.statusCode,
                error: error?.localizedDescription,
                message: error?.localizedDescription,
                path: model.path
            )
            completion(.failure(dto))
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
