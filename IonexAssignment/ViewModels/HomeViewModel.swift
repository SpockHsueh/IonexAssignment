//
//  HomeViewModel.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/12.
//

import Foundation

class HomeViewModel {
    var updateInfo: ObserableObject<Update?> = ObserableObject(nil)
    var userInfo: ObserableObject<User?> = ObserableObject(nil)
    var updateErrorDescription: ObserableObject<String?> = ObserableObject(nil)
    
    func update(timezone: Int,
                objectId: String,
                sessionToken: String
    ) {
        UpdateProfileService.update(timezone: timezone,
                                    objectId: objectId,
                                    sessionToken: sessionToken) { [weak self] updateRes in
            switch updateRes {
            case .failure(let error):
                var errorMessage = ""
                switch error {
                case .invalidURL: errorMessage = "Invalid URL"
                case .missingData: errorMessage = "Missing Data"
                case .unexpectedError(let error):
                    errorMessage = error
                }
                self?.updateErrorDescription.value = errorMessage
            case .success(let update):
                self?.updateInfo.value = update
            }
        }
    }

    func changeProfile(user: User?, timezome: Int?) {
        guard let user = user,
              let timezone = timezome else {
            return
        }

        let newUserInfo = User(username: user.username, timezone: timezone, phone: user.phone, objectId: user.objectId, sessionToken: user.sessionToken)
        self.userInfo.value = newUserInfo
    }
}
