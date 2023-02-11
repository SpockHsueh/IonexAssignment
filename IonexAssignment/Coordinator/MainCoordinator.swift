//
//  MainCoordinator.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/9.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        var vc: UIViewController & Coordinating = LoginVC()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
        
}
