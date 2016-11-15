//
//  MeasurementHelper.swift
//  Beacon
//
//  Created by Lloyd W. Sykes on 11/15/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Firebase

class MeasurementHelper {
    
    static func sendLoginEvent() {
        FIRAnalytics.logEvent(withName: kFIREventLogin, parameters: nil)
    }
    
    static func sendLogoutEvent() {
        FIRAnalytics.logEvent(withName: "logout", parameters: nil)
    }
    
    static func sendMessageEvent() {
        FIRAnalytics.logEvent(withName: "message", parameters: nil)
    }
}
