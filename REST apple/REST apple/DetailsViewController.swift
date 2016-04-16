//
//  DetailsViewController.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/10/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class DetailsViewController: UIViewController {

    @IBOutlet weak var vNameLabel: UILabel!
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var rightsLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var genereLabel: UILabel!
    
    var video: Videos?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateFonts), name: UIContentSizeCategoryDidChangeNotification, object: nil)

    }
  
    func updateUI() {
        if let vid = video {
            
            
            
            vNameLabel.text = vid._vname
            rightsLabel.text = vid._vRights
            priceLabel.text = vid._vPrice
            genereLabel.text = vid._vGenere
            
            if let data = vid.vImageData {
                songImageView.image = UIImage(data: data)
            }else {
                songImageView.image = UIImage(named: "NotAvilable")
            }
        }
    }
    @IBAction func shareButton(sender: UIBarButtonItem) {
        shareMedia()
        
    }
    
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
        guard let url = NSURL(string: (video?._vVideoURL)!) else {
            print("couldn't load video URL")
            return
        }
        
        let player = AVPlayer(URL: url)
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
    }

    func shareMedia(){
        let activity1 = "Have you had the opportunity to see this Music Video?"
        let activity2 = "\(video?._vname) by \(video?._vArtist)"
        let activity3 = "Watch it and tell me what do you think?"
        let activity4 = video?._vLinkITunes
        let activity5 = "(Shared with the Music Video App!)"
        
        let activityViewController = UIActivityViewController(activityItems: [activity1,activity2, activity3, activity4!, activity5], applicationActivities: nil)
        
        // to stop sharing to any service
//        activityViewController.excludedActivityTypes = [UIActivityTypeMail]
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if activity == UIActivityTypeMail {
                print("email selected")
            }
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func updateFonts() {
        vNameLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        rightsLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        priceLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        genereLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }
    
    

 

}
