//
//  MoviesTVCTableViewController.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/5/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

class MoviesTVC: UITableViewController {

    var videos = [Videos]()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var limit = 10

    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(preferedFontChanged), name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
        
        

    }
    
    func preferedFontChanged() -> Void {
        print("font changed")
    }
    
    
   
    @IBAction func refreshFeed(sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        runAPI()
    }
    
    func reachabilityStatusChanged() -> Void {
        switch reachabilityStatus {
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
            let alert = UIAlertController(title: "no connection", message: "make sure you're connected to internet", preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
                action in
                print("Cancel")
            }
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Default) {
                action in
                print("deleted")
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .Default) {
                action in
                print("ok")
            }
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        default:
            if videos.count > 0 {
                print("Don't load")
            }else{
                runAPI()
            }
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
    }

    
    struct StoryBoard {
        static let ReuseIdentfier = "cell"
        static let SegueDetailsIdentfier = "details"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.ReuseIdentfier, forIndexPath: indexPath) as! videoCTVC
        let vid = videos[indexPath.row]
        vid._vrank = indexPath.row
        cell.tag = indexPath.row
        cell.video = vid
        return cell
    }


 



    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == StoryBoard.SegueDetailsIdentfier, let index = tableView.indexPathForSelectedRow {
            guard let dvc = segue.destinationViewController as? DetailsViewController else { return }
            dvc.video = videos[index.row]
            
        }
    }
    
    
    // MARK: - Connetivity functions 
    func getAPICount() {
        
        if let value = defaults.objectForKey("APICNT"){
            limit = Int(value as! NSNumber)
        }
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        let refreshDate = formatter.stringFromDate(NSDate())
        refreshControl?.attributedTitle = NSAttributedString(string: "\(refreshDate)")
    }
    
    
    func runAPI() -> Void {
        getAPICount()
        title = "The iTunes Top \(limit) Music Videos "
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=\(limit)/explicit=true/json", completion: didLoadData)
        
    }
    
    func didLoadData(results: [Videos]) -> Void {
        videos = results
        tableView.reloadData()
    }
    
}
