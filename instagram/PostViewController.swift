//
//  PostViewController.swift
//  instagram
//
//  Created by Audrey Jones on 6/27/17.
//  Copyright © 2017 Audrey Jones. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var uploadPictureButton: UIButton!
    
    @IBOutlet weak var captionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func choosePicture(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        //uploadPictureButton.setTitle("", for: UIControlState())
        photoView.image = editedImage
        //uploadPictureButton.setBackgroundImage(editedImage, for: UIControlState())
        
        // dakjsakjsdaksdj
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func postPhoto(_ sender: Any) {
        let image = photoView.image
        if image != nil {
            Post.postUserImage(image: image, withCaption: captionField.text, withCompletion: nil)
            captionField.text = ""
            photoView.image = nil
        }else {
            let alertController = UIAlertController(title: "Error", message: "Please choose an image to post", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            self.present(alertController, animated: true)
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
