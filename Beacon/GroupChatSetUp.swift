//
//  GroupChatSetUp.swift
//  Beacon
//
//  Created by Lloyd W. Sykes on 11/15/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Firebase
import UIKit

class GroupChatSetUp: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var ref: FIRDatabaseReference!
    var messages: [FIRDataSnapshot]! = []
    fileprivate var _refHandle: FIRDatabaseHandle!
    var storageRef: FIRStorageReference!
    
    override func viewDidLoad() {
        
        self.configureDatabase()
        self.configureStorage()
    }
    
    deinit {
        self.ref.child("messages").removeObserver(withHandle: self._refHandle)
    }
    
    func configureDatabase() {
        
        self.ref = FIRDatabase.database().reference()
        self._refHandle = self.ref.child("messages").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            
            guard let strongSelf = self else { return }
            strongSelf.messages.append(snapshot)
            //            strongSelf.tableView.insertRows(at: [IndexPath(row: strongSelf.messages.count - 1, section: 0)], with: .automatic)
        })
    }
    
    func configureStorage() {
        
        let storageURL = FIRApp.defaultApp()?.options.storageBucket
        self.storageRef = FIRStorage.storage().reference(forURL: "gs://" + storageURL!)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        
        let messageSnapshot: FIRDataSnapshot! = self.messages[indexPath.row]
        let message = messageSnapshot.value as! [String: String]
        let name = message[Constants.MessageFields.name] as String!
        let text = message[Constants.MessageFields.text] as String!
        cell.textLabel?.text = name! + AppState.sharedInstance.location! + ": " + text!
        
        return cell
    }
    
    func sendMessages(withData data: [String: String]) {
        
        var mdata = data
        mdata[Constants.MessageFields.name] = AppState.sharedInstance.displayName
        self.ref.child("messages").childByAutoId().setValue(mdata)
    }
    
}
