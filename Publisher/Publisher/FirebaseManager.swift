//
//  FirebaseManager.swift
//  Publisher
//
//  Created by prince on 2020/11/20.
//

import Foundation
import Firebase
import FirebaseFirestore

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private init() {}
    
    let db = Firestore.firestore()
    
    var posts = [Post]()
    
    
    // MARK: - Add data to Firestore
    
    func addDataForTest() {
        
        let articles = db.collection("articles")
        
        let document = articles.document()
        
        let data: [String: Any] = [
            
            "author": [
                
                "email": "wayne@school.appworks.tw",
                
                "id": "waynechen323",
                
                "name": "AKA小安老師"
                
            ],
            
            "title": "IU「亂穿」竟美出新境界!笑稱自己品味奇怪 網笑:靠顏值撐住女神氣場​",
            
            "content": "南​韓歌手IU(李知恩)無論在歌唱方面或是近期的戲劇作品都有亮眼的成績，但俗話說人無完美、美玉微瑕，曾再跟工作人員的互動影片中坦言自己品味很奇怪，近日在IG上分享了宛如「媽媽們青春時代的玉女歌手」超復古穿搭造型，卻意外美出新境界。​",
            
            "createdTime": Date().timeIntervalSince1970,
            
            "id": document.documentID,
            
            "category": "Beauty"
            
        ]
        
        document.setData(data) { (error) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
        }
    }
    
    func addData(title: String, category: String, content: String) {
        
        let articles = db.collection("articles")
        
        let document = articles.document()
        
        let data: [String: Any] = [
            
            "author": [
                
                "email": "princekili0422@gmail.com",
                
                "id": "princekili",
                
                "name": "Prince"
                
            ],
            
            "title": title,
            
            "content": content,
            
//            "createdTime": Date().timeIntervalSince1970,
            "createdTime": FirebaseFirestore.FieldValue.serverTimestamp(),
            
            "id": document.documentID,
            
            "category": category
            
        ]
        
        document.setData(data) { (error) in
            
            if let error = error {
                
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Get data from Firestore
    
//    func getDocuments() {
//        
//        db.collection("articles")
//            .order(by: "createdTime", descending: true)
//            .getDocuments() { (querySnapshot, error) in
//                
//                if let error = error {
//                    
//                    print("Error getting documents: \(error)")
//                    
//                } else {
//                    
//                    guard let querySnapshot = querySnapshot else { return }
//                    
//                    for document in querySnapshot.documents {
//                        
//                        let data = document.data()
//                        
//                        let id = document.documentID
//                        
//                        print("\(id) => \(data)")
//                        
//                        let title = data["title"] as? String ?? "Untitled"
//                        
//                        let createdTime = "\(data["createdTime"] ?? "No timestamp")"
//                        
//                        let content = data["content"] as? String ?? "None"
//                        
//                        let category = data["category"] as? String ?? "All"
//                        
//                        let authorData = data["author"] as? [String: String] ?? ["": ""]
//                        
//                        let author = Author(email: authorData["email"] ?? "",
//                                            id: authorData["id"] ?? "",
//                                            name: authorData["name"] ?? "")
//                        
//                        let newPost = Post(author: author,
//                                           title: title,
//                                           content: content,
//                                           createdTime: createdTime,
//                                           id: id,
//                                           category: category)
//                        
//                        self.posts.append(newPost)
//                    }
//                }
//            }
//    }
    
    
    // MARK: - Listen to Firestore
    
    func listenToArticles() {
        
        db.collection("articles")
            .addSnapshotListener { (documentSnapshot, error) in
                
                guard let documentSnapshot = documentSnapshot else {
                    
                    print("Error fetching document: \(error!)")
                    
                    return
                }
                
                documentSnapshot.documentChanges.forEach { diff in
                    
                    if (diff.type == .added) {
                        print("新增貼文: \(diff.document.data())")
                    }
                    
                    if (diff.type == .modified) {
                        print("變更貼文: \(diff.document.data())")
                    }
                    
                    if (diff.type == .removed) {
                        print("刪除貼文: \(diff.document.data())")
                    }
                }
            }
    }
    
    // MARK: - Read Firestore Timestamp
    
//    func readTimestamp(timestamp: FieldValue) {
//
//        FirebaseFirestore.FieldValue.serverTimestamp()
//
//        let date = Date(timeIntervalSince1970: )
//    }
}
