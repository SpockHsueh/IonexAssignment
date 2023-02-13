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
    private var showErrorDescription: NSLayoutConstraint?
    private var dismissErrorDescription: NSLayoutConstraint?
    
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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
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
    
    deinit {
        print("LoginVC deinit")
    }
    
    // MARK: - Private Func
    private func setupConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginErrorDescriptionLabel)
        view.addSubview(loginButton)
        
        showErrorDescription = loginErrorDescriptionLabel.heightAnchor.constraint(equalToConstant: 60)
        dismissErrorDescription = loginErrorDescriptionLabel.heightAnchor.constraint(equalToConstant: 0)
        showErrorDescription?.isActive = false
        dismissErrorDescription?.isActive = true
        
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginErrorDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginErrorDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
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
    
    private func highlightTextField(_ textField: UITextField?) {
        
        guard let textField = textField else {
            return
        }
        textField.resignFirstResponder()
        textField.layer.borderWidth = borderWidth
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    private func setupBinders() {
        viewModel.loginErrorDescription.bind { [weak self] value in
            if let value = value {
                self?.loginErrorDescriptionLabel.text = value
                self?.handleErrorDescriptionConstraint(isShow: true)
            }
        }
        
        viewModel.isUsernameTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField(self?.usernameTextField)}
        }
        
        viewModel.isPasswordTextFieldHighLighted.bind { [weak self] in
            if $0 { self?.highlightTextField(self?.passwordTextField)}
        }
        
        viewModel.userInfo.bind {[ weak self] user in
            if let user = user {
                let loginEvent: LoginEvent = .navigateToHome(user: user)
                self?.coordinator?.eventOccurred(with: loginEvent)
                self?.usernameTextField.text = nil
                self?.passwordTextField.text = nil
                self?.view.endEditing(true)
            }
        }
    }
    
    @objc private func loginButtonPressed() {
        
        viewModel.updateCredentials(username: usernameTextField.text ?? "",
                                    password: passwordTextField.text ?? "")
        
        switch viewModel.checkInput() {
            
        case .Correct:
            login()
        case .Incorrect:
            return
        }
    }
    
    private func login() {
        viewModel.login()
    }
    
    private func handleErrorDescriptionConstraint(isShow: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.showErrorDescription?.isActive = isShow
            self.dismissErrorDescription?.isActive = !isShow
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - TextFieldDelegate
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gray.cgColor
        handleErrorDescriptionConstraint(isShow: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

}
