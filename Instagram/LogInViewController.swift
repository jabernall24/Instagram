//
//  LogInViewController.swift
//  Instagram
//
//  Created by Jesus Andres Bernal Lopez on 9/25/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.isSecureTextEntry = true
        loginButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10

    }
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text ?? "", password: passwordField.text ?? "") { (user: PFUser?, error: Error?) in
            if user != nil{
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
            }else{
                self.showAlert(error: error)
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let newUser = PFUser()

        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("yay created a user")
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
            }else{
                self.showAlert(error: error)
            }
        }
    }
    
    func showAlert(error: Error?){
        let alertController = UIAlertController(title: error?.localizedDescription, message: "Please check information and try again.", preferredStyle: .alert)
        let okay = UIAlertAction(title: "Okay", style: .default)
        alertController.addAction(okay)
        self.present(alertController, animated: true)
    }

}
