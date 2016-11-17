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
    
    private struct Constants {
        static let analyzeSentimentBaseURL = "https://language.googleapis.com/v1beta1/documents:analyzeSentiment?key=\(Secrets.googleNaturalLangAPIKey)"
    }
    
    static func obtainJSONContent() {
        print("CALLED FUNCTION")
        
        let jsonFilePath = Bundle.main.path(forResource: "testingLangAPI", ofType: "json")
        print("JSON FILE PATH: \(jsonFilePath)")
        let url = URL(fileURLWithPath: jsonFilePath!)
        let data = try! Data(contentsOf: url)
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        //let jsonData = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        
        print("JSON CONTENT HERE: \(json)")
        //print("JSON DATA: \(jsonData)")
        
        
        let request = NSMutableURLRequest(url: URL(string: Constants.analyzeSentimentBaseURL)!)
        request.httpMethod = "POST"
        request.httpBody = data

        print("request: \(request) \nrequestbody: \(request.httpBody)")
        //requestbody currently prints: Optional(113 bytes), not sure what this means but we'll figure it out!
        
//        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            
//        })
        //ISSUE: ambiguous reference to member dataTask(with:completionHandler:)
    
    }
    
}
