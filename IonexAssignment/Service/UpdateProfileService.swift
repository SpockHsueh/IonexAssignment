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
    }
    
    static func update(timezone: Int,
                       objectId: String,
                       sessionToken: String,
                       completion: @escaping (Result<Update, Error>) -> Void) {
        
        guard let url = URL(string: "https://watch-master-staging.herokuapp.com/api/users/\(objectId)") else {
            completion(.failure(UpdateError.invalidURL))
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
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(UpdateError.missingData))
                return
            }
            
            do {
                let updateResult = try JSONDecoder().decode(Update.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(updateResult))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
