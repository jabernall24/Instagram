//
//  HomeScreenViewController.swift
//  Instagram
//
//  Created by Jesus Andres Bernal Lopez on 9/26/18.
//  Copyright © 2018 Jesus Andres Bernal Lopez. All rights reserved.
//

import UIKit
import Parse
import ParseLiveQuery

class HomeScreenViewController: UIViewController, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var posts: [PFObject] = []
    var refreshController: UIRefreshControl!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.black,
             NSAttributedString.Key.font: UIFont(name: "Billabong", size: 30)!]
        fetchData()
        refreshController = UIRefreshControl()
        refreshController.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshController, at: 0)
        didPullToRefresh(refreshController)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        if posts.count != 0{
            let caption = posts[indexPath.row].object(forKey: "caption")
            cell.captionLabel.text = caption as? String
            
            let image = posts[indexPath.row]["image"] as? PFFile
            image?.getDataInBackground(block: { (data: Data?, error: Error?) in
                if error == nil{
                    let nm = UIImage(data: data!)
                    cell.postImageView.image = nm
                }
            })
        }
        return cell
    }
    
    func fetchData(){
        activityIndicator.startAnimating()
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if error == nil{
                if let posts = posts{
                    self.posts = posts
                    self.tableView.reloadData()
                    self.refreshController.endRefreshing()
                    self.activityIndicator.stopAnimating()
                }
            }else{
                print(error?.localizedDescription as Any)
            }
        }
    }
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let post = posts[indexPath.row]
            let postDetailViewController = segue.destination as! PostDetailViewController
            postDetailViewController.post = post
        }
    }
}
