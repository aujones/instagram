//
//  ProfileViewController.swift
//  instagram
//
//  Created by Audrey Jones on 6/28/17.
//  Copyright © 2017 Audrey Jones. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var posts : [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self

        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.includeKey("author")
        query.findObjectsInBackground { (newPosts: [PFObject]?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.posts = newPosts!
                self.collectionView.reloadData()
            }
            let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(self.refreshControlAction(_:)), for: UIControlEvents.valueChanged)
            self.collectionView.insertSubview(refreshControl, at: 0)
        }
        // Do any additional setup after loading the view.

        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! PicCell
        let post = posts[indexPath.row]
        let image = post["media"] as! PFFile
        image.getDataInBackground { (imageData: Data?, error: Error?) in
            if error == nil {
                let newImage = UIImage(data: imageData!)
                cell.picView.image = newImage
            }
        }
        
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
                self.collectionView.reloadData()
            }
        }
        refreshControl.endRefreshing()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
