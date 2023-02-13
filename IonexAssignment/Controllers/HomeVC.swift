//
//  HomeVC.swift
//  IonexAssignment
//
//  Created by 薛宇振 on 2023/2/12.
//

import Foundation
import UIKit

class HomeVC: UIViewController, Coordinating {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    var userInfo: User?
    var viewModel: HomeViewModel?
    
    // MARK: - UI Component
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 40)
        label.text = "Profile"
        return label
    }()
    
    private lazy var usernameTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Username"
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var timezoneTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Timezone"
        return label
    }()
    
    private lazy var timezoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var phoneTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Phone"
        return label
    }()
    
    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var changeTimezoneButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(changeTimeZoneButtonPressed), for: .touchUpInside)
        button.setTitle("Change Profile", for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.backgroundColor = .black
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.backgroundColor = .lightGray
        return button
    }()
        
    // MARK: - Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
        setupView()
    }
    
    deinit {
        print("homeVC deinit")
    }
    
    // MARK: - Private Func
    
    private func setupView() {
        guard let userInfo = userInfo else {
            return
        }

        usernameLabel.text = userInfo.username
        phoneLabel.text = userInfo.phone
        timezoneLabel.text = String(userInfo.timezone)
    }
    
    private func setupConstraints() {
        view.addSubview(titleLabel)
        
        view.addSubview(usernameTitleLabel)
        view.addSubview(usernameLabel)
        
        view.addSubview(phoneTitleLabel)
        view.addSubview(phoneLabel)
        
        view.addSubview(timezoneTitleLabel)
        view.addSubview(timezoneLabel)
        
        view.addSubview(logoutButton)
        view.addSubview(changeTimezoneButton)
        
        NSLayoutConstraint.activate([
            
            titleLabel.widthAnchor.constraint(equalToConstant: 150),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            usernameTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            usernameTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            usernameTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            usernameLabel.topAnchor.constraint(equalTo: usernameTitleLabel.bottomAnchor, constant: 5),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            phoneTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            phoneTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            phoneTitleLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 20),
            phoneTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            phoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            phoneLabel.topAnchor.constraint(equalTo: phoneTitleLabel.bottomAnchor, constant: 5),
            phoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           
            
            timezoneTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            timezoneTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            timezoneTitleLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 20),
            timezoneTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timezoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            timezoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            timezoneLabel.topAnchor.constraint(equalTo: timezoneTitleLabel.bottomAnchor, constant: 5),
            timezoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            changeTimezoneButton.widthAnchor.constraint(equalTo: timezoneLabel.widthAnchor),
            changeTimezoneButton.topAnchor.constraint(equalTo: timezoneLabel.bottomAnchor, constant: 20),
            changeTimezoneButton.heightAnchor.constraint(equalToConstant: 40),
            changeTimezoneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoutButton.widthAnchor.constraint(equalTo: changeTimezoneButton.widthAnchor),
            logoutButton.topAnchor.constraint(equalTo: changeTimezoneButton.bottomAnchor, constant: 20),
            logoutButton.heightAnchor.constraint(equalToConstant: 40),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }
    
    @objc private func logoutButtonPressed() {
        let homeType: HomeEvent = .navigationToLogin
        coordinator?.eventOccurred(with: homeType)
    }
    
    @objc private func changeTimeZoneButtonPressed() {
        
        alertWithTextField(title: "Change Timezone",
                           placeholder: "\(String(describing: userInfo?.timezone))") { [weak self] changedTimezone in
            self?.viewModel
        }
    }
    
    private func alertWithTextField(title: String? = nil, message: String? = nil, placeholder: String? = nil, completion: @escaping ((String) -> Void) = { _ in }) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField() { newTextField in
            newTextField.placeholder = placeholder
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in completion("") })
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            if
                let textFields = alert.textFields,
                let firstTextField = textFields.first,
                let result = firstTextField.text
            { completion(result) }
            else
            { completion("") }
        })
        let homeType: HomeEvent = .showChangeTimezoneAlert(alert: alert)
        coordinator?.eventOccurred(with: homeType)
    }
    
}

