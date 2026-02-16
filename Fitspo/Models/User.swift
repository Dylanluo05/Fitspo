//
//  User.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/12/26.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    let fullName: String
    let dateOfBirth: Date
    let createdAt: Date
    
    init?(from document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard
            let email = data["email"] as? String,
            let username = data["username"] as? String,
            let fullName = data["fullName"] as? String,
            let dobTimestamp = data["dateOfBirth"] as? Timestamp,
            let createdAtTimestamp = data["createdAt"] as? Timestamp
        else {
            return nil
        }
        
        self.id = document.documentID
        self.email = email
        self.username = username
        self.fullName = fullName
        self.dateOfBirth = dobTimestamp.dateValue()
        self.createdAt = createdAtTimestamp.dateValue()
    }
}
