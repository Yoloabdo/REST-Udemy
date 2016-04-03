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
        api.loadData("http://tech-echo.com/api/get_recent_posts/", completion: didLoadData)
    }

    func didLoadData(result: String) -> Void {
        
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }


}

