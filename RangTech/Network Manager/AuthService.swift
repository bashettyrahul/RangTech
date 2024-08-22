import Foundation

class AuthService {
    static let shared = AuthService()
    
    private let baseURL = "http://localhost:5001/api"
    
    func register(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/register") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let data = data {
                
                let responseString = String(data: data, encoding: .utf8) ?? "No Response Data"
                print("Response Data: \(responseString)")
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    if let data = data, let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.error])
                        completion(.failure(error))
                    } else {
                        completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)))
                    }
                }
            }
        }.resume()
    }
    
    func login(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/login") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(user)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)")
            }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let data = data {
                
                let responseString = String(data: data, encoding: .utf8) ?? "No Response Data"
                print("Response Data: \(responseString)")
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    completion(.success(()))
                } else {
                    if let data = data, let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        let error = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.error])
                        completion(.failure(error))
                    } else {
                        completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: nil)))
                    }
                }
            }
        }.resume()
    }
}
