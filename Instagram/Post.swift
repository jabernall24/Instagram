//
//  Post.swift
//  Instagram
//
//  Created by Jesus Andres Bernal Lopez on 9/26/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class Post: PFObject, PFSubclassing {
    
    @NSManaged var author: PFUser
    @NSManaged var image: PFFile
    @NSManaged var caption: String
    @NSManaged var commentsCount: Int
    @NSManaged var likesCount: Int
    
    static func parseClassName() -> String {
        return "Post"
    }
    
    func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // use subclass approach
        let post = Post()
        
        // Add relevant fields to the object
        post.image = getPFFileFromImage(image: image)! // PFFile column type
        post.author = PFUser.current()! // Pointer column type that points to PFUser
        post.caption = caption ?? ""
        post.likesCount = 0
        post.commentsCount = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackground(block: completion)
    }
    
    func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = image.pngData() {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    
    
}
