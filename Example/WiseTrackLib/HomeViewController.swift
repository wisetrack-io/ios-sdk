//
//  HomeViewController.swift
//  WiseTrackLib
//
//  Created by Mostafa Movahhed on 12/8/1403 AP.
//  Copyright © 1403 AP CocoaPods. All rights reserved.
//
import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to the Home Screen!"
        welcomeLabel.textAlignment = .center
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            backButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func backTapped() {
        dismiss(animated: true, completion: nil)
    }
}
