//
//  ProfielViewController.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 12.05.2023.
//

import UIKit
import FirebaseAuth

class ProfielViewController: UIViewController {

    private let signOutButton: UIButton = {
        let button =  UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8.0
        button.backgroundColor = UIColor(named: "MainColor")
        button.setTitleColor(.white, for: .normal)
       
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(52)
            make.centerY.equalToSuperview()
        }
        signOutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        
        
      
    }
    
    @objc func signOut() {
        do {
            try Auth.auth().signOut()
            handleNotAuthenticated()
        }
        catch {
            print("error")
        }
        print("Current User: \(String(describing: Auth.auth().currentUser ?? nil))" )
    }
    
    private func handleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }

}
