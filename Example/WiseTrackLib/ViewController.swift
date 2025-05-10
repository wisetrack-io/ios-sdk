//
//  ViewController.swift
//  WiseTrackLib
//
//  Created by 29954885 on 01/11/2025.
//  Copyright (c) 2025 29954885. All rights reserved.
//

import UIKit
import WiseTrackLib

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .white

        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "wisetrack-logo")
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        

//        let label = UILabel()
//        label.text = "WiseTrack iOS Library"
//        label.textColor = .black
//        label.textAlignment = .center
//        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        
        
        let button1 = UIButton()
        button1.setTitle("Create Default Event", for: .normal)
        button1.addTarget(self, action: #selector(onCreateDefaultEvent), for: .touchUpInside)
        button1.setTitleColor(.blue, for: .normal)
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)
        
        let button2 = UIButton()
        button2.setTitle("Create Custom Event", for: .normal)
        button2.addTarget(self, action: #selector(onCreateCustomEvent), for: .touchUpInside)
        button2.setTitleColor(.blue, for: .normal)
        button2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button2)
        
        let button3 = UIButton()
        button3.setTitle("Create Revenue Event", for: .normal)
        button3.addTarget(self, action: #selector(onCreateRevenueEvent), for: .touchUpInside)
        button3.setTitleColor(.blue, for: .normal)
        button3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button3)
        
    
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),

            button1.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 16),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 16),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func onCreateDefaultEvent(sender: UIButton!){
        WiseTrack.shared.setFCMToken(token: "Asghar FCM Token")
//        WiseTrack.shared.logEvent(WTEvent.default(for: "Default Event from iOS"))
    }
    
    @objc func onCreateCustomEvent(sender: UIButton!){
        WiseTrack.shared.logEvent(WTEvent.default(for: "Custom Event from iOS", params: [
            "key-str": .string("value"),
            "key-num": .num(1.1),
            "key-bool": .bool(true)
        ]))
    }
    
    @objc func onCreateRevenueEvent(sender: UIButton!){
        WiseTrack.shared.logEvent(WTEvent.revenue(for: "Revenue Event from iOS", currency: .IRR, amount: 120000, params: [
            "key-str-rev": .string("value"),
            "key-num-rev": .num(1.1),
            "key-bool-rev": .bool(true)
        ]))
    }
}

extension Date {
    func isoFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZ"
        return dateFormatter.string(from: self)
    }
}
