//
//  CreatePostViewModel.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/15/26.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit

class CreatePostViewModel: ObservableObject {
    
    @Published var isUploading = false
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    func createPost(image: UIImage, title: String, caption: String, hashtagText: String, completion: @escaping (Bool) -> Void) {
        
        guard let user = Auth.auth().currentUser else {
            completion(false)
            return
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.7) else {
            completion(false)
            return
        }
        
        isUploading = true
        
        let fileName = UUID().uuidString
        let storageRef = storage.reference()
            .child("post_images/\(user.uid)/\(fileName).jpg")
        let hashtags = parseHashtags(from: hashtagText)
        
        storageRef.putData(imageData, metadata: nil) { _, error in
            if let error = error {
                print("Upload error: \(error)")
                self.isUploading = false
                completion(false)
                return
            }
            
            storageRef.downloadURL { url, error in
                
                guard let downloadURL = url else {
                    self.isUploading = false
                    completion(false)
                    return
                }
                
                
                self.savePost(
                    userId: user.uid,
                    title: title,
                    imageUrl: downloadURL.absoluteString,
                    caption: caption,
                    hashtags: hashtags,
                    completion: completion
                )
            }
        }
    }
    
    private func savePost(userId: String, title: String, imageUrl: String, caption: String, hashtags: [String], completion: @escaping (Bool) -> Void) {
        
        db.collection("posts").addDocument(data: [
            "userId": userId,
            "title": title,
            "imageUrl": imageUrl,
            "caption": caption,
            "hashtags": hashtags,
            "timestamp": FieldValue.serverTimestamp()
        ]) { error in
            
            self.isUploading = false
            
            if let error = error {
                print("Firestore error: \(error)")
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    private func parseHashtags(from text: String) -> [String] {
        text
            .split(separator: " ")
            .map { $0.replacingOccurrences(of: "#", with: "") }
            .map { $0.lowercased() }
    }
}

