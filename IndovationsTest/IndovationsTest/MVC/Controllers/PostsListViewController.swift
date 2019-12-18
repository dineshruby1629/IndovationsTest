
//
//  PostsListViewController.swift
//  IndovationsTest
//
//  Created by dinesh chandra on 18/12/19.
//  Copyright © 2019 Indovations. All rights reserved.
//

import UIKit

class PostsListViewController: UIViewController {
    
    @IBOutlet weak var postListTableView: UITableView!
    
    // MARK: - Array
    var postListArray:[PostObjects] = []
    var selectedPostListArray = [PostObjects]()
    var page = 1
    
    // MARK: - Refreshing Object
    
    let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let postCell = UINib(nibName: String(describing: PostCell.self), bundle: nil)
        postListTableView.register(postCell, forCellReuseIdentifier: String(describing: PostCell.self))
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        postListTableView.refreshControl = refreshControl
        self.requestPosts(page: 1)
        self.title = "Selected " + String(selectedPostListArray.count)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func refreshPosts() {
        self.requestPosts(page: 1)
        self.refreshControl.endRefreshing()
        selectedPostListArray.removeAll()
        self.title = "Selected " + String(selectedPostListArray.count)

    }
    
    func appendPosts(additionalPosts : [PostObjects]) {
        for post in additionalPosts {
            self.postListArray.append(post)
        }
    }
    
    
    func requestPosts(page: Int) {
        
        let requestUrlString = ServiceApi.Base_API+"\(page)"
        RestService.getPostsList(requestUrlString, finish: { (Posts) in
            
            if (page == 1) {
                
                self.postListArray.removeAll()
                self.postListArray = Posts.hits
                
            } else {
                
                self.appendPosts(additionalPosts: Posts.hits)
                
            }
            
            DispatchQueue.main.async {
                
                self.postListTableView.reloadData()
                
            }
        })
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension PostsListViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return postListArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else { return UITableViewCell() }
        
        
        let post = self.postListArray[indexPath.row]
        
        cell.configureingPostData(post)
        
        cell.postSwitch?.addTarget(self, action: #selector(toggleSwitch), for: .valueChanged)
        
        if self.selectedPostListArray.contains(where: { $0.objectID == post.objectID }) {
            
            cell.postSwitch?.setOn(true, animated: true)
            
        }else {
            
            cell.postSwitch?.setOn(false, animated: true)
            
        }
        
        if indexPath.row == postListArray.count-1 {
            page = page + 1
            self.requestPosts(page: page)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let post = self.postListArray[indexPath.row]
        
        if let post = selectedPostListArray.firstIndex(where: { $0.objectID == post.objectID }) {
            
            self.selectedPostListArray.remove(at: post)
            
        }else{
            
            self.selectedPostListArray.append(post)
        }
        
        tableView.reloadData()
        self.title = "Selected " + String(selectedPostListArray.count)
        
    }
    
    @objc func toggleSwitch(sender: UISwitch) {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.postListTableView)
        let indexPath = self.postListTableView.indexPathForRow(at: buttonPosition)
        let post = self.postListArray[(indexPath?.row)!]
        if let post = selectedPostListArray.firstIndex(where: { $0.objectID == post.objectID }) {
            self.selectedPostListArray.remove(at: post)
        }
        else
        {
            self.selectedPostListArray.append(post)
        }
        
        self.title = "Selected " + String(self.selectedPostListArray.count)
        postListTableView.reloadData()
        
    }
    
    
    
}
