//
//  LoginViewModel.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/11.
//

import Foundation

class LoginViewModel {
    
    var loginErrorDescription: ObserableObject<String?> = ObserableObject(nil)
    var userInfo:  ObserableObject<User?> = ObserableObject(nil)
    var isUsernameTextFieldHighLighted: ObserableObject<Bool> = ObserableObject(false)
    var isPasswordTextFieldHighLighted: ObserableObject<Bool> = ObserableObject(false)
    private var username = ""
    private var password = ""
    
    func updateCredentials(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func login() {
        
        LoginService.login(withName: username,
                           password: password) { [weak self] loginRes in
            
            switch loginRes {
            case .failure(let error):
                var errorMessage = ""
                switch error {
                case .invalidURL: errorMessage = "Invalid URL"
                case .missingData: errorMessage = "Missing Data"
                case .unexpectedError(let error):
                    errorMessage = error
                }
                self?.loginErrorDescription.value = errorMessage
                
            case .success(let user):
                self?.userInfo.value = user
            }
        }
    }
    
    func checkInput() -> InputStatus {
        if username.isEmpty && password.isEmpty {
            loginErrorDescription.value = "Please provide username and password"
            return .Incorrect
        }
        
        if username.isEmpty {
            loginErrorDescription.value = "Username field is empty"
            isUsernameTextFieldHighLighted.value = true
            return .Incorrect
        }
        
        if password.isEmpty {
            loginErrorDescription.value = "Password field is empty"
            isPasswordTextFieldHighLighted.value = true
            return .Incorrect
        }
        
        return .Correct
    }
}

extension LoginViewModel {
    enum InputStatus {
        case Correct
        case Incorrect
    }
}
