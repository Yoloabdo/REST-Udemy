//
//  SettingsTableViewController.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/14/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    
    @IBOutlet weak var aboutLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var securityLabel: UILabel!
    
    @IBOutlet weak var bestImageQuality: UILabel!
    
    @IBOutlet weak var APICnt: UILabel!
    
    @IBOutlet weak var sliderCnt: UISlider!
    @IBOutlet weak var touchID: UISwitch!
    
    private struct StoryBoard {
        static let SecurityKey = "SecSettings"
    }
    
    @IBAction func touchIdSec(sender: UISwitch) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
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
        
        touchID.on = NSUserDefaults.standardUserDefaults().boolForKey(StoryBoard.SecurityKey)
        
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
