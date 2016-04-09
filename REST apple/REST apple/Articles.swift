//
//  Articles.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/9/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import Foundation

class Articles {
    var title: String?
    var date: String?
    var content: String?
    var url: String?
    var id: Int?
    var excerpt: String?
    var articleThumbnailURL: String?
    
    
    var thumbnailImageData: NSData?
    
    func encodedURL(url: String) -> String {
        let urlString = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        return urlString!
    }
    
    init(data: JSONDictionary) {
        
        // the name
        guard let idA = data["id"] as? Int
            else {
                print("couldn't parse ID ")
                return
        }
        
        guard let titleA = data["title"] as? String
            else {
                print("couldn't parse Title ")
                return
        }
        
        guard let dateA = data["date"] as? String
            else {
                print("couldn't parse date ")
                return
        }
        
        guard let contentA = data["content"] as? String
            else {
                print("couldn't parse content ")
                return
        }
        
        guard let thumb = data["thumbnail"] as? String
            else {
                print("couldn't parse thumbnail ")
                return
        }
        
        guard let excer = data["excerpt"] as? String
            else {
                print("couldn't parse excerpt ")
                return
        }

        
        id = idA
        title = titleA
        date = dateA
        content = contentA
        articleThumbnailURL = thumb
        excerpt = excer
        
    }
}