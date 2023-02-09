//
//  Coordinator.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/9.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
