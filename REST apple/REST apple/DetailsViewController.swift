//
//  DetailsViewController.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/10/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
