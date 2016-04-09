//
//  MoviesTVCTableViewController.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/5/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

class ArticlesTVC: UITableViewController {

    var articles = [Articles]()
    
    @IBOutlet weak var tableHeader: UINavigationItem! {
        didSet{
            let myCustomView = UIImageView()
            let myImage: UIImage = UIImage(named: "logo")!
            
            myCustomView.image = myImage
            myCustomView.contentMode = .ScaleAspectFit
            myCustomView.frame.size.width = 145;
            myCustomView.frame.size.height = 60;
            myCustomView.frame.origin = CGPoint(x: 2, y: 8)

            tableHeader.titleView = myCustomView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
       
        

    }
   
    
    func runAPI() -> Void {
        let api = APIManager()
        api.loadData("http://tech-echo.com/api/get_recent_posts/", completion: didLoadData)
    }
    
    func didLoadData(results: [Articles]) -> Void {
        articles = results
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
            if articles.count > 0 {
                print("Don't load")
            }else{
                runAPI()
            }
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

    
    struct StoryBoard {
        static let ReuseIdentfier = "cell"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(StoryBoard.ReuseIdentfier, forIndexPath: indexPath) as! ArticleCTVC
 
        cell.article = articles[indexPath.row]
        return cell
    }



}
