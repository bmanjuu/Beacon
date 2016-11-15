//
//  AppState.swift
//  Beacon
//
//  Created by Lloyd W. Sykes on 11/15/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

class AppState {
    
    static let sharedInstance = AppState()
    var signedIn = false
    var displayName: String?
    var location: String?
}
