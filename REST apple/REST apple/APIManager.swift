//
//  APIManager.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/3/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import Foundation
class APIManager {
    
    
    func loadData(urlString: String, completion: [Videos] -> Void) {
        
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
                
                do {
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                    feed = json["feed"] as? JSONDictionary,
                    entries = feed["entry"] as? JSONArray
                    {
                        var videos = [Videos]()
                        for entry in entries {
                            let entry = Videos(data: entry as! JSONDictionary)
                            videos.append(entry)
                        }

                        let proirity = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(proirity, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(videos)
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