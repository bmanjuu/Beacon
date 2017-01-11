//
//  State.swift
//  Beacon
//
//  Created by Lloyd W. Sykes on 1/10/17.
//  Copyright © 2017 Betty Fung. All rights reserved.
//

import Foundation

class State: NSObject {
    
    static let sharedInstance = State()
    var signedIn = false
    var displayName: String?
    var location: String?
}
