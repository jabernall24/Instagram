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
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func onSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil{
                print("you're logged in")
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
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
                print(error?.localizedDescription ?? "")
                if error?._code == 202{
                    print("username is taken.")
                }
            }
        }
    }

}
