//
//  GroupChatViewController.swift
//  Beacon
//
//  Created by Lloyd W. Sykes on 1/10/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import UIKit
import Firebase

class GroupChatViewController: UIViewController {
    
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    let cellId = "chatCell"
    var ref: FIRDatabaseReference!
    var messages: [FIRDataSnapshot]! = []
    fileprivate var _refHandle: FIRDatabaseHandle!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        viewCustomizations()
        configureDatabase()
    }
    
    deinit {
        self.ref.child("messages").removeObserver(withHandle: _refHandle)
    }
    
    func viewCustomizations() {
        chatTableView.delegate = self
        chatTableView.dataSource = self
        messageTextField.delegate = self
    }
    
    func configureDatabase() {
        ref = FIRDatabase.database().reference()
        
        _refHandle = self.ref.child("messages").observe(.childAdded, with: { [weak self] (snapshot) -> Void in
            guard let strongSelf = self else { return }
            strongSelf.messages.append(snapshot)
            strongSelf.chatTableView.insertRows(at: [IndexPath(row: strongSelf.messages.count - 1,section: 0)], with: .automatic)
        })
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        textFieldShouldReturn(messageTextField)
    }
    
    func sendMessage(withData data: [String: String]) {
        var mdata = data
        mdata["name"] = State.sharedInstance.displayName
        mdata["location"] = State.sharedInstance.location
        ref.child("messages").childByAutoId().setValue(mdata)
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        State.sharedInstance.signedIn = false
    }
}

extension GroupChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let messageSnapshot = messages[indexPath.row]
        let message = messageSnapshot.value as! [String: String]
        let name = message["name"]
        let text = message["text"]
        
        cell.textLabel?.text = name! + ": " + text!
        
        return cell
        
    }
}

extension GroupChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = messageTextField.text else { return true }
        let data = ["text": text]
        sendMessage(withData: data)
        return true
    }
}
