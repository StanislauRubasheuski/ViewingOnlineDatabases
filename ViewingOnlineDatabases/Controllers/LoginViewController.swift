//
//  ViewController.swift
//  ViewingOnlineDatabases
//
//  Created by Stanislau on 28.05.2018.
//  Copyright © 2018 Stanislau. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    let model = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        model.login = loginTF.text ?? ""
        model.password = passwordTF.text ?? ""
        
        model.userValidation(success: {
            let nc = self.storyboard?.instantiateViewController(withIdentifier: "controller") as! UINavigationController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = nc
        }) {
            self.errorLabel.text = "Wrong login or password"
            self.passwordTF.text = ""
            self.loginTF.text = ""
        }
    }
    
    func setupUI() {
        signInButton.layer.cornerRadius = 6
    }
}

