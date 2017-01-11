//
//  UserInputViewController.swift
//  Beacon
//
//  Created by Laticia Chance on 11/20/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import UIKit
import Firebase

class UserInputViewController: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
    }



}
