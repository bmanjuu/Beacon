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
    //2. call sentiment analyzer API (may need to modify argument name of API method call to more accurately reflect what we're passing in... maybe 'messages'?) -- figure out how many messages you want to process at once so that we stay under limit!
    //3. assess the results
    //4. filter out negative stuff / keep neutral - positive posts
    //5. may need to create a list of words that we definitely do not want to be passed around in the community (i.e. offensive terms that the sentiment analyzer may not necessarily understand)
    
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
    
    typealias SentimentAnalysisCompletion = (NSDictionary?, Error?) -> ()
    
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
            
            if let data = response.result.value as? NSDictionary {
                completion(data, nil)
            }
            
            }
        }
    
//    static func obtainFirebaseChatJSON(completion: @escaping (NSDictionary?, Error?) ->()) {
//        print("obtain firebase JSON function called")
//        Alamofire.request("https://friendlychat-f69f0.firebaseio.com/").responseJSON { (response) in
//            print("firebase response: \(response)")
//            if let jsonResponse = response.result.value as? NSDictionary {
//                completion(jsonResponse, nil)
//            }
//        }
//    }
    
}

