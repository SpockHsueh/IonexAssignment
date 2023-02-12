//
//  User.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/11.
//

import Foundation

struct User: Codable {
    let username: String
    let timezone: Int
    let phone: String
    let objectId: String
    let sessionToken: String
}
