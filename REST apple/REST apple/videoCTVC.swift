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
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
