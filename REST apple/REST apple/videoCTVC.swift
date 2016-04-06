//
//  videoTVC.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/5/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

class videoCTVC: UITableViewCell {

    @IBOutlet weak var rank: UILabel!
    @IBOutlet weak var musicTitle: UILabel!
    
    @IBOutlet weak var videoImageView: UIImageView!
    

    var video: Videos?{
        didSet{
            updateUI()
        }
    }
    
    
    func updateUI() {
        
        musicTitle.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        rank.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        // to prevent loading old images.
        videoImageView.image = nil
        
        rank.text = "\(video!._vrank! + 1)"
        musicTitle.text = video?._vname
        
        guard let data = video?.vImageData else {
            "download image"
            getVideoImage(video!, imageView: videoImageView)
            return
        }
        
        print("Get data from array")
        videoImageView.image = UIImage(data: data)
 
    }
    
    func getVideoImage(video: Videos, imageView: UIImageView)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            let data = NSData(contentsOfURL: NSURL(string: video._vImageURL!)!)
            
            var image: UIImage?
            
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                if self.tag == video._vrank {
                    imageView.image = image
                }
            }
            
        }
        
    }

}
