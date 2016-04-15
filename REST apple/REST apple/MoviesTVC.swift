//
//  MoviesTVCTableViewController.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/5/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

class MoviesTVC: UITableViewController, UISearchResultsUpdating {

    var videos = [Videos]()
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    var limit = 10

    var filterSearch = [Videos]()
    var resultSearchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()

    }
    
    
   
    @IBAction func refreshFeed(sender: UIRefreshControl) {
        refreshControl?.endRefreshing()
        if resultSearchController.active {
            refreshControl?.attributedTitle = NSAttributedString(string: "No refresh Allowed in search")
        }else {
            runAPI()
        }
    }
 
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        
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
        if resultSearchController.active {
            return filterSearch.count
        }
        return videos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.ReuseIdentfier, forIndexPath: indexPath) as! videoCTVC
        
        if resultSearchController.active {
            cell.video = filterSearch[indexPath.row]
        }else{
            cell.video = videos[indexPath.row]
        }
        
        
        return cell
    }


 



    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == StoryBoard.SegueDetailsIdentfier, let index = tableView.indexPathForSelectedRow {
            
            guard let dvc = segue.destinationViewController as? DetailsViewController else { return }
            
            if resultSearchController.active{
                dvc.video = filterSearch[index.row]
            }else {
                dvc.video = videos[index.row]
            }
        }
    }
    
    
    // MARK: - Connetivity functions
    func getAPICount() {
        
        if let value = defaults.objectForKey("APICNT"){
            limit = Int(value as! NSNumber)
        }
        
        let formatter = NSDateFormatter()
        formatter.timeStyle = .MediumStyle
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
        definesPresentationContext = true
        resultSearchController.searchResultsUpdater = self
        resultSearchController.dimsBackgroundDuringPresentation = false
        resultSearchController.searchBar.placeholder = "Search Videos"
        resultSearchController.searchBar.searchBarStyle = UISearchBarStyle.Prominent
        
        //adding the search bar to the view
        tableView.tableHeaderView = resultSearchController.searchBar
        
        tableView.reloadData()
        
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
    
    // MARK: -Search 
    
    func filterSearch(searchText: String) {
        filterSearch = videos.filter {
            videos in
            return (videos._vArtist?.lowercaseString.containsString(searchText.lowercaseString))!
        }
        
        tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text?.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }
    
}
