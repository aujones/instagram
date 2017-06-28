//
//  FeedViewController.swift
//  instagram
//
//  Created by Audrey Jones on 6/27/17.
//  Copyright © 2017 Audrey Jones. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(vc, animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = UIImagePickerControllerEditedImage as! UIImage
        
        // dakjsakjsdaksdj
        dismiss(animated: true, completion: nil)
        
    }
 
    @IBAction func logOut(_ sender: Any) {
        PFUser.logOutInBackground { (error: Error?) in
        }
        NotificationCenter.default.post(name: NSNotification.Name("logoutNotification"), object: nil)
        
        
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
