//
//  videoTVC.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/5/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

class videoCTVC: UITableViewCell {

    @IBOutlet weak var SongNameLabel: UILabel!
    @IBOutlet weak var ArtistNameLabel: UILabel!
    
    @IBOutlet weak var videoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var video: Videos?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI() {
        SongNameLabel.text = video?._vArtist
        ArtistNameLabel.text = video?._vname
        
        
        if video!.vImageData != nil {
            print("Get data from array")
            videoImageView.image = UIImage(data: (video?.vImageData)!)
        }
        else {
            getVideoImage(video!, imageView: videoImageView)
        }
    }
    
    func getVideoImage(video: Videos, imageView: UIImageView)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: NSURL(string: video._vImageURL!)!)
            
            var image: UIImage?
            
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
            
        }
        
    }

}
