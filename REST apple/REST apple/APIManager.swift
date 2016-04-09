//
//  APIManager.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/3/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import Foundation
class APIManager {
    func loadData(urlString: String, completion: (result: String) -> Void){
        
        // setting cache to nill through setting instead of the delegate file
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
//        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)
        
        let task = session.dataTaskWithURL(url!) {
            (data, response, error) in
            
            if error != nil {
                dispatch_async(dispatch_get_main_queue())  {
                    completion(result: error!.localizedDescription)
                }
            }else {
                // to encode arabic letters, seems to be working with this line
//                let data = data?.base64EncodedDataWithOptions(.EncodingEndLineWithCarriageReturn)
                
                guard var dataString = String(data: data!, encoding: NSUTF8StringEncoding) else{
                    print("string error")
                    return
                }
                
                dataString = dataString.substringToIndex(dataString.endIndex.advancedBy(-82))
                
                let dataMod = dataString.dataUsingEncoding(NSUTF8StringEncoding)
                
                do {
                    guard let json = try NSJSONSerialization.JSONObjectWithData(dataMod!, options: .AllowFragments) as? [String:AnyObject] else {
                        print("not parsed as array")
                        return
                    }
                    print(json)
                        
                    let proirity = DISPATCH_QUEUE_PRIORITY_HIGH
                    dispatch_async(dispatch_get_global_queue(proirity, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(result: "JSON serialization successful")
                        }
                    }
                } catch {
                    dispatch_async(dispatch_get_main_queue()) {
                        print(error)
                        completion(result: "Erorr in JSONSErialization")
                    }
                }
            
            }
        }
        
        task.resume()
    }
}