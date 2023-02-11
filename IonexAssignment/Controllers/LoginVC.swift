//
//  LoginVC.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/11.
//

import Foundation
import UIKit

class LoginVC: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    private let borderWidth = 0.5
    private let viewModel = LoginViewModel()
    
    // MARK: - UI Component
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = borderWidth
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "UserName"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = borderWidth
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        return textField
    }()
    
    private lazy var loginErrorDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .red
        label.textAlignment = .center
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.backgroundColor = .black
        return button
    }()
    
    // MARK: - Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setupBinders()
    }
    
    // MARK: - Private Func
    private func setupConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(loginErrorDescriptionLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginErrorDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginErrorDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            loginErrorDescriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            
            loginErrorDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                    
            usernameTextField.topAnchor.constraint(equalTo: loginErrorDescriptionLabel.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),
            usernameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func highlightTextField(_ textField: UITextField) {
        textField.resignFirstResponder()
        textField.layer.borderWidth = borderWidth
        textField.layer.borderColor = UIColor.red.cgColor        
    }
    
    private func setupBinders() {
        viewModel.loginErrorDescription.bind { [weak self] value in
            self?.loginErrorDescriptionLabel.text = value
        }
        
        viewModel.error.bind { [weak self] error in
            if let error = error {
                // do some error handle
            } else {
                // go to next page
            }
        }
    }
    
    @objc private func loginButtonPressed() {
        
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           usernameTextField.resignFirstResponder()
           passwordTextField.resignFirstResponder()
           return true
       }
       
       func textFieldDidBeginEditing(_ textField: UITextField) {
           loginErrorDescriptionLabel.isHidden = true
           textField.layer.borderColor = UIColor.gray.cgColor
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
}
