//
//  RegisterViewController.swift
//  Instagram
//
//  Created by Jesus Andres Bernal Lopez on 9/26/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Username"
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(onRegisterButton), for: .touchUpInside)
        return button
    }()
    
    @objc func onRegisterButton(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }

    func setUpView() {
        view.addSubview(usernameTextField)
        usernameTextField.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55).isActive = true
        usernameTextField.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        usernameTextField.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        usernameTextField.safeAreaLayoutGuide.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
