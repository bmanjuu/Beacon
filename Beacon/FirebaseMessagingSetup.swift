//
//  FirebaseMessagingSetup.swift
//  Beacon
//
//  Created by Lloyd W. Sykes on 11/15/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import UIKit
import Firebase

class FirebaseMessagingSetup: UIViewController {
    
    let nameTextField = UITextField()
    let locationTextField = UITextField()
    let signInButton = UIButton()
    
    override func viewDidLoad() {
        if let user = FIRAuth.auth()?.currentUser {
            self.signedIn(user)
        }
    }

    func signedIn(_ user: FIRUser?) {
        
        MeasurementHelper.sendLoginEvent()

        AppState.sharedInstance.displayName = user?.displayName ?? "Anonymous"
        AppState.sharedInstance.location = self.locationTextField.text ?? nil
        AppState.sharedInstance.signedIn = true
        let notificationName = Notification.Name(rawValue: Constants.NotificationKeys.signedIn)
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo: nil)
        //performSegue
    }
}
