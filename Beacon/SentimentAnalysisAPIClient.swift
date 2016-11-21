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
    
    //1. obtain JSON chat file (collaborate with Lloyd on this)
    //2. direct this JSON chat file for the 'document' part of the HTTP call to the sentiment analyzer API
    //3. make the API call (NSURLSession)
    //4. assess the results 
    //5. filter out negative stuff / keep neutralish - positive posts
    
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
    
}

