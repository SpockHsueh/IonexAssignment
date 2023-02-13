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
        vc.viewModel = HomeViewModel()
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func eventOccurred(with type: Event) {
        guard let type = type as? HomeEvent else {
            return
        }
        
        switch type {
        case .navigationToLogin:
            _ = navigationController?.popToRootViewController(animated: false)
            parentCoordinator?.childDidFinish(self)
        case .showAlert(let alert):
            _ = navigationController?.present(alert, animated: true)
        }
    }
    
    deinit {
        print("HomeCoordinator deinit")
    }
    
}
