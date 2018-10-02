//
//  CaptureViewController.swift
//  Instagram
//
//  Created by Jesus Andres Bernal Lopez on 9/26/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit
import Parse

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var shareActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var captureImageView: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        captionTextView.delegate = self
        textPlaceholder()
        
        shareButton.isUserInteractionEnabled = true
        logOutButton.isUserInteractionEnabled = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if captionTextView.textColor == .lightGray {
            captionTextView.text = nil
            captionTextView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if captionTextView.text.isEmpty {
            textPlaceholder()
        }
    }
    
    func textPlaceholder(){
        captionTextView.text = "Write a caption..."
        captionTextView.textColor = .lightGray
    }
    
    @IBAction func onLogOut(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
            print("you logged out")
            self.performSegue(withIdentifier: "logOut", sender: self)
        }
    }
    
    @IBAction func onShare(_ sender: Any) {
        self.captionTextView.resignFirstResponder()
        if captureImageView.image == UIImage(named: "image_placeholder"){
            let alert = UIAlertController(title: "Posting an image is required", message: "Please upload an image to be able to post", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Okay", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
            return
        }
        if captionTextView.textColor == .lightGray{
            captionTextView.text = ""
        }
        
        shareButton.isUserInteractionEnabled = false
        self.logOutButton.isUserInteractionEnabled = false
        self.shareActivityIndicator.startAnimating()
        
        let newPost = Post()
        newPost.postUserImage(image: resize(image: captureImageView.image!), withCaption: captionTextView.text) { (success: Bool, error: Error?) in
            if success{
                self.textPlaceholder()
                self.captureImageView.image = UIImage(named: "image_placeholder")
            }else{
                let errorAlert = UIAlertController(title: "Failed to upload", message: "Please try again later", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Okay", style: .default)
                errorAlert.addAction(okay)
                self.present(errorAlert, animated: true)
                print("error: " + (error?.localizedDescription)!)
            }
            self.shareActivityIndicator.stopAnimating()
            self.shareButton.isUserInteractionEnabled = true
            self.logOutButton.isUserInteractionEnabled = true
        }
    }
    
    @IBAction func onKeyboardHide(_ sender: Any) {
        captionTextView.resignFirstResponder()
    }
    
    @IBAction func onTap(_ sender: Any) {
        
        let vc = UIImagePickerController()
        
        vc.delegate = self
        vc.allowsEditing = true
        
        
        let alertController = UIAlertController(title: "Please choose", message: "Photo library or use camera for image", preferredStyle: .alert)
        let library = UIAlertAction(title: "Library", style: .default) { (action) in
            if action.isEnabled == true{
                vc.sourceType = UIImagePickerController.SourceType.photoLibrary
                self.present(vc, animated: true, completion: nil)
            }
        }
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in
            if action.isEnabled == true{
                vc.sourceType = UIImagePickerController.SourceType.camera
                self.present(vc, animated: true, completion: nil)
                
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(library)
        alertController.addAction(camera)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        self.captureImageView.image = originalImage
        dismiss(animated: true, completion: nil)
    }
    
    func resize(image: UIImage) -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: view.frame.width - 30, height: 345))
        let resizeImageView = UIImageView(frame: rect)
        resizeImageView.contentMode = UIView.ContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }

    
}
