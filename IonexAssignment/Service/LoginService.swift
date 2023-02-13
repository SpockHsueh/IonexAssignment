//
//  LoginService.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/11.
//

import Foundation

struct LoginService {
    
    enum LoginError: Error {
        case invalidURL
        case missingData
        case unexpectedError(error: String)
    }
    
    static func login(withName name: String,
                      password: String,
                      completion: @escaping (Result<User, LoginError>) -> Void) {
        
        guard let url = URL(string: "https://watch-master-staging.herokuapp.com/api/login") else {
            DispatchQueue.main.async {
                completion(.failure(LoginError.invalidURL))
            }
            return
        }
        
        let parameters: [String: Any] = [
            "username": name,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("vqYuKPOkLQLYHhk4QTGsGKFwATT4mBIGREI2m8eD", forHTTPHeaderField: "X-Parse-Application-Id")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters,
                                                         options: []) else {
            return
        }
        
        request.httpBody = httpBody

        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(LoginError.unexpectedError(error: error.localizedDescription)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(LoginError.missingData))
                }
                return
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            
            guard (200...299).contains(status) else {
                
                if let errorJson = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String,Any> {
                    if let error = errorJson["error"] as? String {
                        DispatchQueue.main.async {
                            completion(.failure(LoginError.unexpectedError(error: error)))
                        }
                    }
                }
                return
            }
            
            do {
                let loginResult = try JSONDecoder().decode(User.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(loginResult))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(LoginError.unexpectedError(error: error.localizedDescription)))
                }
            }
            
        }.resume()
        
    }
}
