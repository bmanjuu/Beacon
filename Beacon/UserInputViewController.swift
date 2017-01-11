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

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        // Do any additional setup after loading the view.
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        textFieldShouldReturn(messageTextField)
    }

    func sendMessage(withData data: [String: String]) {
        var mdata = data
        mdata["name"] = State.sharedInstance.displayName
        mdata["location"] = State.sharedInstance.location
        ref.child("messages").childByAutoId().setValue(mdata)
        
    }


}

extension UserInputViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = messageTextField.text else { return true }
        let data = ["text": text]
        sendMessage(withData: data)
        return true
    }
    
}
