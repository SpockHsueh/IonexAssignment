//
//  ViewController.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/9.
//

import UIKit

class ViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
    }
}

