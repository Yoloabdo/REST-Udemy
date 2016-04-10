//
//  ArticleDetailsViewController.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/10/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    @IBOutlet weak var articleView: UITextView!

    var article: Articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleView.text = article?.content

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
