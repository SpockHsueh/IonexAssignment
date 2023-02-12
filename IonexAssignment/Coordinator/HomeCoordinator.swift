//
//  HomeCoordinator.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/12.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController?
    var homeViewModel = HomeViewModel()
    var userInfo: User?
    
    func start() {
        let vc = HomeVC()
        vc.coordinator = self
        vc.userInfo = userInfo
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func eventOccurred(with type: Event) {
        
    }
    
    deinit {
        print("123")
    }
    
}
