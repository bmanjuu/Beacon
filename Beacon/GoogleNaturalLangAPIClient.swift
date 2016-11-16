//
//  GoogleNaturalLangAPIClient.swift
//  Beacon
//
//  Created by Betty Fung on 11/15/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation

struct GoogleNaturalLangAPIClient {
    
    //1. obtain JSON chat file (collaborate with Lloyd on this)
    //2. direct this JSON chat file for the 'document' part of the HTTP call to the sentiment analyzer API
    //3. make the API call (NSURLSession)
    //4. assess the results 
    //5. filter out negative stuff / keep neutralish - positive posts
    
//    static let chatJSONData = try? String(contentsOfFile: "testingLangAPI.json")
    //json file is dictionary
    
    
    //options: nsjsonserialization, bundle path stuff
    
    static func printStuff() {
        print("CALLED FUNCTION")
        
        let jsonFilePath = Bundle.main.path(forResource: "testingLangAPI", ofType: "json")
        print("JSON FILE PATH: \(jsonFilePath)")
        let url = URL(fileURLWithPath: jsonFilePath!)
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        
        print("JSON CONTENT HERE: \(json)")
        
    }
    
}
