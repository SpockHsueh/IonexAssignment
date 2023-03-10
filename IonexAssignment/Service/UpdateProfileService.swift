//
//  UpdateProfileService.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/12.
//

import Foundation

struct UpdateProfileService {
    
    enum UpdateError: Error {
        case invalidURL
        case missingData
        case unexpectedError(error: String)
    }
    
    static func update(timezone: Int,
                       objectId: String,
                       sessionToken: String,
                       completion: @escaping (Result<Update, UpdateError>) -> Void) {
        
        guard let url = URL(string: "https://watch-master-staging.herokuapp.com/api/users/\(objectId)") else {
            DispatchQueue.main.async {
                completion(.failure(UpdateError.invalidURL))
            }
            return
        }
        
        let parameters: [String: Any] = [
            "timezone": timezone,
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("vqYuKPOkLQLYHhk4QTGsGKFwATT4mBIGREI2m8eD", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(sessionToken, forHTTPHeaderField: "X-Parse-Session-Token")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters,
                                                         options: []) else {
            return
        }
        
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(UpdateError.unexpectedError(error: error.localizedDescription)))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(UpdateError.missingData))
                }
                return
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            
            guard (200...299).contains(status) else {
                
                if let errorJson = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String,String> {
                    if let error = errorJson["error"] {
                        DispatchQueue.main.async {
                            completion(.failure(UpdateError.unexpectedError(error: error)))
                        }
                    }
                }
                return
            }
            
            do {
                let updateResult = try JSONDecoder().decode(Update.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(updateResult))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(UpdateError.unexpectedError(error: error.localizedDescription)))
                }
            }
            
        }.resume()
    }
}
