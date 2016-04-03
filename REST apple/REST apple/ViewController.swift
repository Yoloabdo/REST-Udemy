//
//  ViewController.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/1/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/explicit=true/json", completion: didLoadData)
    }

    func didLoadData(results: [Videos]) -> Void {
        print(reachabilityStatus)
        
        let alert = UIAlertController(title: ("\(results.count)"), message: nil, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }


}

