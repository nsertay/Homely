//
//  ViewController.swift
//  Homely
//
//  Created by Nurmukhanbet Sertay on 06.04.2023.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let database = Firestore.firestore()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
      
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func kbDidShow(notification: Notification) {
        
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + kbFrameSize.height)
    }
    
    @objc func kbDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height)
    }

    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, email != "", password != "" else {
            errorAlert(text: "Info is incorrect")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self ] (user, error) in
            if error != nil {
                self?.errorAlert(text: error!.localizedDescription)
                return
            }
            
            if user != nil {
                self?.performSegue(withIdentifier: "gototab", sender: nil)
                return
            }
            self?.errorAlert(text: error!.localizedDescription)
        })
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "register", sender: nil)
    }
    
    func errorAlert(text: String) {
        
        let errorAlertController = UIAlertController(title: "", message: text, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .destructive)
        errorAlertController.addAction(alertAction)
        
        present(errorAlertController, animated: true)
    }
}

