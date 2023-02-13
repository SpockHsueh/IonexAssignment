//
//  Coordinator.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/9.
//

import Foundation
import UIKit

protocol Event {}

enum LoginEvent: Event {
    case navigateToHome(user: User)
}

enum HomeEvent: Event {
    case navigationToLogin
    case showAlert(alert: UIAlertController)
}

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    func start()
    func eventOccurred(with type: Event)
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

extension Coordinator {
    func childDidFinish(_ coordinator : Coordinator){
        for (index, child) in children.enumerated() {
            if child === coordinator {
                children.remove(at: index)
                break
            }
        }
    }
}
