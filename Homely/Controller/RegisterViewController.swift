//
//  RegisterViewController.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 06.04.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            
            errorAlert(text: "Info is incorrect")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
            if error == nil {
                if user != nil {
                    self?.performSegue(withIdentifier: "gototab", sender: nil)
                }
            } else {
                self?.errorAlert(text: error!.localizedDescription)
            }
        }
    }
    
    func errorAlert(text: String) {
        
        let errorAlertController = UIAlertController(title: "", message: text, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Ok", style: .destructive)
        errorAlertController.addAction(alertAction)
        
        present(errorAlertController, animated: true)
    }
}
