//
//  PostDetailViewController.swift
//  Instagram
//
//  Created by Jesus Andres Bernal Lopez on 9/29/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class PostDetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    var post: PFObject! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = post.object(forKey: "author") as? PFUser
        authorLabel.text = userName?.username
        
        let date = post.createdAt
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        let result = formatter.string(from: date!)
        timestampLabel.text = result
        
        let caption = post.object(forKey: "caption")
        captionLabel.text = caption as? String
        
        let image = post["image"] as? PFFile
        image?.getDataInBackground(block: { (data: Data?, error: Error?) in
            if error == nil{
                let nm = UIImage(data: data!)
                self.detailImageView.image = nm
            }
        })
        
    }
}
