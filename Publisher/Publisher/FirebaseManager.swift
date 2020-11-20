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
    
    
}
