//
//  ViewController.swift
//  Publisher
//
//  Created by prince on 2020/11/20.
//

import UIKit
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    let firebase = FirebaseManager.shared
    
    var posts = [Post]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
//        firebase.listenToArticles()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        showData()
        
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addNewPostBtnDidTap(_ sender: UIButton) {
    }
    
    func showData() {
        
//        getDocuments(completionHandler: { newPost in
//
//            self.posts.append(newPost)
//        })
        
//        posts = firebase.posts
        
        getDocuments()
        
        DispatchQueue.main.async {
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Get data from Firestore
    
//    func getDocuments(completionHandler: @escaping (Post) -> Void) {
    func getDocuments() {
        
        db.collection("articles")
            .order(by: "createdTime", descending: true)
            .getDocuments() { (querySnapshot, error) in
                
                if let error = error {
                    
                    print("Error getting documents: \(error)")
                    
                } else {
                    
                    guard let querySnapshot = querySnapshot else { return }
                    
                    for document in querySnapshot.documents {
                        
                        let data = document.data()
                        
                        let id = document.documentID
                        
                        print("\(id) => \(data)")
                        
                        let title = data["title"] as? String ?? "Untitled"
                        
                        let createdTime = "\(data["createdTime"] ?? "No timestamp")"
                        
                        let content = data["content"] as? String ?? "None"
                        
                        let category = data["category"] as? String ?? "All"
                        
                        let authorData = data["author"] as? [String: String] ?? ["": ""]
                        
                        let author = Author(email: authorData["email"] ?? "",
                                            id: authorData["id"] ?? "",
                                            name: authorData["name"] ?? "")
                        
                        let newPost = Post(author: author,
                                           title: title,
                                           content: content,
                                           createdTime: createdTime,
                                           id: id,
                                           category: category)
                        
                        self.posts.append(newPost)
                    }
                    
                    self.tableView.reloadData()
                }
            }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { posts.count }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        
//        cell.setup(title: firebase.posts[indexPath.row].title,
//                   name: firebase.posts[indexPath.row].author.name,
//                   time: firebase.posts[indexPath.row].createdTime,
//                   category: firebase.posts[indexPath.row].category,
//                   content: firebase.posts[indexPath.row].content)
        
        cell.setup(title: posts[indexPath.row].title,
                   name: posts[indexPath.row].author.name,
                   time: posts[indexPath.row].createdTime,
                   category: posts[indexPath.row].category,
                   content: posts[indexPath.row].content)
        
        
//        cell.setup(title: "Test",
//                   name: "Test",
//                   time: "Test",
//                   category: "Test",
//                   content: "Test")
        
        return cell
    }



}

