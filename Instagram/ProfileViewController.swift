//
//  ProfileViewController.swift
//  Instagram
//
//  Created by Jesus Andres Bernal Lopez on 9/26/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            print("you logged out")
            self.performSegue(withIdentifier: "logOutSegue", sender: self)
        }
    }
}
