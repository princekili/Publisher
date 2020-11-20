//
//  PostDataModel.swift
//  Publisher
//
//  Created by prince on 2020/11/20.
//

import Foundation

struct Data {
    
    let data: [Post]
}

struct Post {
    
    let author: Author
    
    let title: String
    
    let content: String
    
    let createdTime: String
    
    let id: String
    
    let category: String
}

struct Author {
    
    let email: String
    
    let id: String
    
    let name: String
}
