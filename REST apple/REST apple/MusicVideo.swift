//
//  MusicVideo.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/3/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import Foundation


class Videos {
    
    var _vname: String?
    var _vImageURL: String?
    var _vVideoURL: String?
    var _vRights: String?
    var _vArtist: String?
    var _vImId: String?
    var _vGenere: String?
    var _vLinkITunes: String?
    var _vReleaseDate: String?
    var _vPrice: String?
    var _vrank: Int?
    
    
    // this var gets created from the UI
    var vImageData: NSData?
    
    init(data: JSONDictionary) {

        // the name
        guard let name = data["im:name"] as? JSONDictionary,
            vName = name["label"] as? String
            else {
                print("couldn't parse Name ")
                return
        }
        // the video image
        guard let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            imaglink = image["label"] as? String
            else {
                print("couldn't parse IMAGEURL ")
                return
        }
        // the video URL
        guard let video = data["link"] as? JSONArray,
            vURL = video[1] as? JSONDictionary,
            vHref = vURL["attributes"] as? JSONDictionary,
            vVideoURL = vHref["href"] as? String
            else {
                print("couldn't parse VideoURL ")
                return
        }
        // the rights
        guard let rights = data["rights"] as? JSONDictionary,
            right = rights["label"] as? String
            else {
                print("couldn't parse rights ")
                return
        }
        
        // the Artist name
        guard let artistName = data["im:artist"] as? JSONDictionary,
            artist = artistName["label"] as? String
            else {
                print("couldn't parse ArtistName ")
                return
        }
        
        // the video id
        guard let id = data["id"] as? JSONDictionary,
            attr = id["attributes"] as? JSONDictionary,
            vidID = attr["im:id"] as? String
            else {
                print("couldn't parse video id ")
                return
        }
        
        // the Genere
        guard let category = data["category"] as? JSONDictionary,
            catAttr = category["attributes"] as? JSONDictionary,
            genere = catAttr["label"] as? String
            else {
                print("couldn't parse video Genere ")
                return
        }
        
        // iTunes link
        guard let link = id["label"] as? String
            else {
                print("couldn't parse video iTunes link ")
                return
        }
        
        
        // release date
        guard let dateID = data["im:releaseDate"] as? JSONDictionary,
            dateAttr = dateID["attributes"] as? JSONDictionary,
            date = dateAttr["label"] as? String
            else {
                print("couldn't parse video ReleaseDate ")
                return
        }
        
        // price 
        guard let imPrice = data["im:price"] as? JSONDictionary,
            priceLabel = imPrice["label"] as? String
            else {
                print("couldn't parse price ")
                return
        }
        
        
        
        _vname = vName
        _vImageURL = imaglink.stringByReplacingOccurrencesOfString("100x100", withString: "450x450")
        _vVideoURL = vVideoURL
        _vRights = right
        _vArtist = artist
        _vImId = vidID
        _vGenere = genere
        _vLinkITunes = link
        _vReleaseDate = date
        _vPrice = priceLabel
        
    }
    
    
    

}