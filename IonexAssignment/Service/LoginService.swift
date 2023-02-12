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
    }
    
    static func login(withName name: String,
                      password: String,
                      completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let url = URL(string: "https://watch-master-staging.herokuapp.com/api/login") else {
            completion(.failure(LoginError.invalidURL))
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

        URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(LoginError.missingData))
                return
            }
            
            do {
                let loginResult = try JSONDecoder().decode(User.self, from: data)
                completion(.success(loginResult))
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
        
    }
}
