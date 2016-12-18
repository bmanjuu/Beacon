//
//  SentimentAnalysisAPIClient.swift
//  Beacon
//
//  Created by Betty Fung on 11/15/16.
//  Copyright © 2016 Betty Fung. All rights reserved.
//

import Foundation
import Alamofire

struct SentimentAnalysisAPIClient {
    
    //0. access messages from firebase
    //1. format messages from firebase so that it can be passed into sentiment API
            // 'json' file is technically an array of dictionaries
            // each dictionary = 1 message 
            // dictionary format: ["text" : "blah blah bloop bloop batman",
            //                     "name" : "a girl has no name"]
    //2. call sentiment analyzer API (may need to modify argument name of API method call to more accurately reflect what we're passing in... maybe 'messages'?) -- figure out how many messages you want to process at once so that we stay under limit! (can be kicked off at certain times of the day, may need to differentiate messages based on their time stamp so we're not analyzing the same message twice)
    //3. assess the results
    //4. filter out negative stuff / keep neutral - positive posts
    //5. ** V2 ** may need to create a list of words that we definitely do not want to be passed around in the community (i.e. offensive terms that the sentiment analyzer may not necessarily understand)
    
    private struct Constants {
        static let analyzeSentimentBaseURL = "http://www.sentiment140.com/api/bulkClassifyJson"
    }
    
    static func obtainJSONContent() -> [String:Any] {
        let jsonFilePath = Bundle.main.path(forResource: "testingLangAPI", ofType: "json")
        print("JSON FILE PATH: \(jsonFilePath)")
        let url = URL(fileURLWithPath: jsonFilePath!)
        let testData = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: testData, options: []) as! [String: Any]
        //let jsonData = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        
        print("JSON CONTENT HERE: \(json)")
        //print("JSON DATA: \(jsonData)")
        
        return json
    }
    
    
    
    enum NaturalLangAPIError: Error {
        case InvalidJSONDictionaryCast
        case InvalidDictionaryResponseKey
        case InvalidDictionaryDocsKey
    }
    
    typealias SentimentAnalysisCompletion = ([[String:Any]]?, Error?) -> ()
    
    static func analyzeSentiment(json: [String:Any], completion: @escaping SentimentAnalysisCompletion) {

        let parameters : Parameters = json
        
        Alamofire.request(Constants.analyzeSentimentBaseURL, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            print("inside alamofire:\nparameters: \(parameters)")
            print("response: \(response)")
            
            switch response.result {
                case .failure(let error):
                    print("this is the error: \(error)")
                    completion(nil, error)
                case .success(let value):
                    print("value: \(value)")
            }
            
            if let data = response.result.value as? [String:Any] {
                
                guard let messageData = data["data"] as? [[String: Any]] else {
                        print("failed to extract message data from response result")
                        completion(nil, NaturalLangAPIError.InvalidJSONDictionaryCast)
                        return
                }
                
                print("message data: \(messageData)")
                
                completion(self.removeNegativeMessages(messages: messageData), nil)
            }
            
        }
    }
    
    static func removeNegativeMessages(messages: [[String:Any]]) -> [[String:Any]] {
        //negative < neutral < positive
        //   0     <    2    <    4
        
        var filteredMessages = messages
        
        var count = 1
        
        for (index, message) in filteredMessages.enumerated() {
            print("message: \(count) - \(message)")
            count += 1
            
            guard let messagePolarity = message["polarity"] as? Int else {
                print("error: \(NaturalLangAPIError.InvalidJSONDictionaryCast)")
                break
            }
            
            if messagePolarity < 2 {
                filteredMessages.remove(at: index)
                //V2: keep negative messages for future analysis and to see if there are other words we need to filter out/be more vigilant of
            }
            
        }
        
        print("\n\n\n\n\n\n\n-------- GOOD VIBES ONLY <3 --------\n")
        print("BEFORE FILTERING:\n \(messages)\n")
        print("AFTER FILTERING:\n \(filteredMessages)\n")
        
        return filteredMessages
        
    }
}

