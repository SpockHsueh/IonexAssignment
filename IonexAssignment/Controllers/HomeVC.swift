//
//  HomeVC.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/12.
//

import Foundation
import UIKit

class HomeVC: UIViewController, Coordinating {
    var coordinator: Coordinator?
    var userInfo: User?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // TODO
        // when back to sign up page
        coordinator?.parentCoordinator?.childDidFinish(coordinator!)
    }
    
    deinit {
        print("deinit")
    }
    
}

