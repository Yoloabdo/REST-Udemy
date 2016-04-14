//
//  SettingsTableViewController.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/14/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

class SettingsTableViewController: UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    

    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var securityLabel: UILabel!
    
    @IBOutlet weak var bestImageQuality: UILabel!
    
    @IBOutlet weak var APICnt: UILabel!
    
    @IBOutlet weak var sliderCnt: UISlider!
    @IBOutlet weak var touchID: UISwitch!

    @IBAction func sliderAPICnt(sender: UISlider) {
        let value = Int(sender.value)
        defaults.setObject(value, forKey: StoryBoard.APICount)
        APICnt.text = "\(value) "
    }
    
    private struct StoryBoard {
        static let SecurityKey = "SecSettings"
        static let APICount = "APICNT"
        static let DefaultDownloadedAPIValue = 10
    }
    
    @IBAction func touchIdSec(sender: UISwitch) {
        
        if touchID.on {
            defaults.setBool(true, forKey: StoryBoard.SecurityKey)
        }else {
            defaults.setBool(false, forKey: StoryBoard.SecurityKey)
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(updateFonts), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        title = "settings"
        
        touchID.on = defaults.boolForKey(StoryBoard.SecurityKey)
        
        guard let value = defaults.objectForKey(StoryBoard.APICount) else {
            APICnt.text = "\(StoryBoard.DefaultDownloadedAPIValue)"
            sliderCnt.value = Float(StoryBoard.DefaultDownloadedAPIValue)
            return
        }
        APICnt.text = "\(value)"
        sliderCnt.value = Float(value as! NSNumber)
        
    }
    
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }
    
    func updateFonts() -> Void {
        aboutLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageQuality.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
}
