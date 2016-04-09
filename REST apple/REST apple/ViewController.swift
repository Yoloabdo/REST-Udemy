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
        
        api.loadData("http://tech-echo.com/api/get_recent_posts/", completion: didLoadData)
        
    }

    func didLoadData(results: [Articles]) -> Void {
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

