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
            
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    completion(result: error!.localizedDescription)
                }else {
                    completion(result: "NSURLSession is successful")
                    // to encode arabic letters, seems to be working with this line
                    let data = data?.base64EncodedDataWithOptions(.EncodingEndLineWithCarriageReturn)
                    print(data)
                }
            }
        }
        
        task.resume()
    }
}