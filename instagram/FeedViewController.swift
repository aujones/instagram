//
//  FeedViewController.swift
//  instagram
//
//  Created by Audrey Jones on 6/27/17.
//  Copyright © 2017 Audrey Jones. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var postTableView: UITableView!
    
    var posts : [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTableView.delegate = self
        postTableView.dataSource = self
        
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.findObjectsInBackground { (newPosts: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.posts = newPosts!
                self.postTableView.reloadData()
            }
        }
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        postTableView.insertSubview(refreshControl, at: 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        let caption = post["caption"] as! String
        let image = post["media"] as! PFFile
        image.getDataInBackground { (imageData: Data?, error: Error?) in
            if error == nil {
                let newImage = UIImage(data: imageData!)
                cell.postImageView.image = newImage
            }
        }
        
        let numLikes = post["likesCount"]
        let numLikesNum = numLikes as! NSNumber
        let numLikesString : String = numLikesNum.stringValue
        //cell.postImageView.image = image
        cell.captionLabel.text = caption
        cell.numLikesLabel.text = numLikesString
        let user = post["author"] as? PFUser
        cell.topUsernameLabel.text = user?.username
        cell.bottomUsernameLabel.text = user?.username
        
        return cell
    }
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.findObjectsInBackground { (newPosts: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.posts = newPosts!
                self.postTableView.reloadData()
            }
        }
        refreshControl.endRefreshing()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
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
