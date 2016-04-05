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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()

        let api = APIManager()
        
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/explicit=true/json", completion: didLoadData)
        
    }

    func didLoadData(results: [Videos]) -> Void {
        print(reachabilityStatus)
        
        
    }

    func reachabilityStatusChanged() -> Void {
        switch reachabilityStatus {
        case WWAN:
            self.view.backgroundColor = UIColor.yellowColor()
        case WIFI:
            view.backgroundColor = UIColor.greenColor()
        case NOACCESS:
            view.backgroundColor = UIColor.redColor()
        default:
            return
        }
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }

}

