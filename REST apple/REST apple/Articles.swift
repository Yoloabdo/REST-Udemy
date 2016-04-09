//
//  Articles.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/9/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import Foundation

class Articles {
    
    //MARK:- local vars
    
    var title: String?
    var date: String?
    var content: String?
    var url: String?
    var id: Int?
    private var excerpt: String?
    private var articleThumbnailURL: String?
    var thumbnailImageData: NSData?
    
  
    
    // MARK:- safe getters
    
    var encodedThumbnailURL: String {
        get {
            return encodedURL(articleThumbnailURL!)
        }
    }
    
    var shorDescribtion: String {
        get {
            return (excerpt?.deleteHTMLTags(["p"]))!
        }
    }
    
    
    // Initializer 
    
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
    
    //MARK:- Helper functions 
    
    func encodedURL(url: String) -> String {
        let urlString = url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLFragmentAllowedCharacterSet())
        return urlString!
    }
    
    
}

extension String {
    func deleteHTMLTag(tag:String) -> String {
        return self.stringByReplacingOccurrencesOfString("(?i)</?\(tag)\\b[^<]*>", withString: "", options: .RegularExpressionSearch, range: nil)
    }
    
    func deleteHTMLTags(tags:[String]) -> String {
        var mutableString = self
        for tag in tags {
            mutableString = mutableString.deleteHTMLTag(tag)
        }
        return mutableString
    }
}
