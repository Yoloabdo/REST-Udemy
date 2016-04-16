//
//  SettingsTableViewController.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/14/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
// it lacks the High image Quality option plus security, but it's doable later anytime. 
// most of the app functionality now is done. about page is left blank as nothing much to say about this app apperantly 


import UIKit
import MessageUI

class SettingsTableViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    

    @IBOutlet weak var aboutButton: UIButton!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var securityLabel: UILabel!
    
    @IBOutlet weak var bestImageQuality: UILabel!
    
    @IBOutlet weak var APICnt: UILabel!
    @IBOutlet weak var numberOfvideosLabel: UILabel!
    @IBOutlet weak var feedbackBtnLabel: UIButton!
    
    @IBOutlet weak var dragSliderLabel: UILabel!
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
    
    // MARK:- MAIL functions 
    
    @IBAction func feedBackBtn(sender: UIButton) {
        
        let mailCompVC = configureMail()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailCompVC, animated: true, completion: nil)
        }else{
            mailAlert()
        }
        
    }
    
    func configureMail() -> MFMailComposeViewController {
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients(["dhooom.da@gmail.com"])
        mailComposeVC.setSubject("Music app feedBack")
        mailComposeVC.setMessageBody("Hello Abdo, \n\nI would like to share the following feedback ...\n", isHTML: false)
        return mailComposeVC
    }
    
    func mailAlert() -> Void {
        let alertCV = UIAlertController(title: "Mail Error", message: "No Email Account setup on iPhone", preferredStyle: .Alert)
        let alert = UIAlertAction(title: "ok", style: .Default, handler: nil)
        alertCV.addAction(alert)
        self.presentViewController(alertCV, animated: true, completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResultCancelled.rawValue:
            print("mail Canceled")
        case MFMailComposeResultSent.rawValue:
            print("mail send")
            
        default:
            print("Unknown issue")
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
        aboutButton.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedbackBtnLabel.titleLabel!.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageQuality.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        numberOfvideosLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        dragSliderLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
        
    }
}
