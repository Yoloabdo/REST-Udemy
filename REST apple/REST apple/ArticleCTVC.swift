//
//  videoTVC.swift
//  REST apple
//
//  Created by Abdulrhman  eaita on 4/5/16.
//  Copyright © 2016 Abdulrhman  eaita. All rights reserved.
//

import UIKit

class ArticleCTVC: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var shortText: UILabel!
    
    @IBOutlet weak var articleHeader: UIImageView!
    

    var article: Articles?{
        didSet{
            updateUI()
        }
    }
    
    
    func updateUI() {
        
        title.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        shortText.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        // to prevent loading old images.
        articleHeader.image = nil
        
        title.text = article?.title
        shortText.text = article?.excerpt
        
        guard let data = article?.thumbnailImageData else {
            // network loading
            getArticleImage(article!, imageView: articleHeader)
            return
        }
        // loading it from the array videos calss.
        articleHeader.image = UIImage(data: data)
 
    }
    
    func getArticleImage(article: Articles, imageView: UIImageView)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            guard let imageURL = article.articleThumbnailURL else {
                print("error loading url")
                return
            }
            let escapedAddress = imageURL.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())

            
            guard let data = NSData(contentsOfURL: NSURL(string:escapedAddress!)!) else {
                print("error fetching image at url : \(imageURL)")
                return
            }
            
            var image: UIImage?
            article.thumbnailImageData = data
            image = UIImage(data: data)
            
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
            
        }
        
    }

}
