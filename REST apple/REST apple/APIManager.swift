//
//  APIManager.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/3/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import Foundation
class APIManager {
    
    
    func loadData(urlString: String, completion: [Articles] -> Void) {
        
        // setting cache to nill through setting instead of the delegate file
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
//        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)
        
        let task = session.dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            }else {
                // to encode arabic letters, seems to be working with this line
//                let data = data?.base64EncodedDataWithOptions(.EncodingEndLineWithCarriageReturn)
                
                // tech-echo fix
                var dataMod = data
                guard var dataString = String(data: data!, encoding: NSUTF8StringEncoding) else{
                    print("string error")
                    return
                }
                if dataString.hasSuffix("-->") {
                    dataString = dataString.substringToIndex(dataString.endIndex.advancedBy(-82))
                    
                    dataMod = dataString.dataUsingEncoding(NSUTF8StringEncoding)

                }

                
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(dataMod!, options: .AllowFragments) as? JSONDictionary,
                    entries = json["posts"] as? JSONArray
                    {
                        var articles = [Articles]()
                        for entry in entries {
                            let entry = Articles(data: entry as! JSONDictionary)
                            articles.append(entry)
                        }

                        let proirity = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(proirity, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(articles)

                            }
                        }
                    }
                } catch {
                    print("Error in NSJSON serialization")
                }
            
            }
        }
        
        task.resume()
    }
}