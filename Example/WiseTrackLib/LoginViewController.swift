//
//  LoginViewController.swift
//  WiseTrackLib
//
//  Created by Mostafa Movahhed on 12/8/1403 AP.
//  Copyright © 1403 AP CocoaPods. All rights reserved.
//
import UIKit


class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let logoImageView = UIImageView(image: UIImage(named: "wisetrack-logo"))
        logoImageView.contentMode = .scaleAspectFit
//        logoImageView.isUserInteractionEnabled = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let usernameTextField = UITextField()
        usernameTextField.placeholder = "Username"
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .green
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabel = UILabel()
        messageLabel.text = "Please enter your credentials"
        messageLabel.textAlignment = .center
//        messageLabel.isUserInteractionEnabled = true
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: usernameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: usernameTextField.trailingAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            loginButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func loginTapped() {
        let homeVC = HomeViewController()
        homeVC.modalPresentationStyle = .fullScreen
        present(homeVC, animated: true, completion: nil)
    }
}
