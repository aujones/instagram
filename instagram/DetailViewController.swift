//
//  DetailViewController.swift
//  instagram
//
//  Created by Audrey Jones on 6/28/17.
//  Copyright © 2017 Audrey Jones. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {

    var post : PFObject? = nil
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var bottomUsernameLabel: UILabel!
    @IBOutlet weak var numLikesLabel: UILabel!
    @IBOutlet weak var topUsernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = post {
            let caption = post["caption"] as! String
            let image = post["media"] as! PFFile
            image.getDataInBackground { (imageData: Data?, error: Error?) in
                if error == nil {
                    let newImage = UIImage(data: imageData!)
                    self.postImageView.image = newImage
                }
            }
            
            let numLikes = post["likesCount"]
            let numLikesNum = numLikes as! NSNumber
            let numLikesString : String = numLikesNum.stringValue
            captionLabel.text = caption
            numLikesLabel.text = numLikesString
            let user = post["author"] as? PFUser
            topUsernameLabel.text = user?.username
            bottomUsernameLabel.text = user?.username
            let profPic = user?["profile_pic"] as! PFFile
            profPic.getDataInBackground { (imageData: Data?, error: Error?) in
                if error ==  nil {
                    let newImage = UIImage(data:imageData!)
                    self.profileImageView.image = newImage
                }
            }
            
        }

        // Do any additional setup after loading the view.
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
