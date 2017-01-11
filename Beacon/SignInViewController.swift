//
//  SignInViewController.swift
//  Beacon
//
//  Created by Lloyd W. Sykes on 1/10/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var anonButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        
        guard
            let name = nameTextField.text,
            let location = locationTextField.text else {
                return
        }
        
        State.sharedInstance.displayName = name
        State.sharedInstance.location = location
        State.sharedInstance.signedIn = true
        performSegue(withIdentifier: "signInSegue", sender: nil)
    }
    
    @IBAction func anonTapped(_ sender: Any) {
        State.sharedInstance.displayName = "Anonymous"
        State.sharedInstance.signedIn = true
        performSegue(withIdentifier: "anonSegue", sender: nil)
    }
    
}
