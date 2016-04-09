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
                print("couldn't parse Title ")
                return
        }
        
        guard let contentA = data["content"] as? String
            else {
                print("couldn't parse Title ")
                return
        }
        
        guard let thumb = data["thumbnail"] as? String
            else {
                print("couldn't parse Title ")
                return
        }

        
        id = idA
        title = titleA
        date = dateA
        content = contentA
        articleThumbnailURL = thumb
        
        
    }
}