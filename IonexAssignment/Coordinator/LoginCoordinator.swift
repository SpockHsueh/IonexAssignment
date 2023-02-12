//
//  MainCoordinator.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/9.
//

import Foundation
import UIKit

class LoginCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController?
    
    func start() {
        var vc: UIViewController & Coordinating = LoginVC()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    
    func eventOccurred(with type: Event) {
        switch type {
        case .navigateToHome(let user):
            let homeCoordinator = HomeCoordinator()
            homeCoordinator.parentCoordinator = self
            homeCoordinator.userInfo = user
            homeCoordinator.navigationController = navigationController
            children.append(homeCoordinator)
            homeCoordinator.start()
            
            parentCoordinator?.childDidFinish(self)
        case .navigationToLogin:
            break
        }
    }
        
}
