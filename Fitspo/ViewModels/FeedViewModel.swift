//
//  FeedViewModel.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/19/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class FeedViewModel: ObservableObject {
    
    @Published var posts: [Post] = []
    
    private var db = Firestore.firestore()
    
    init() {
        fetchPosts()
    }
    
    func fetchPosts() {
        db.collection("posts")
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                
                guard let documents = snapshot?.documents else {
                    print("No documents")
                    return
                }
                
                self.posts = documents.compactMap { doc in
                    let data = doc.data()
                    
                    guard let userId = data["userId"] as? String,
                          let imageUrl = data["imageUrl"] as? String,
                          let caption = data["caption"] as? String,
                          let timestamp = data["timestamp"] as? Timestamp
                    else { return nil }
                    
                    return Post(
                        id: doc.documentID,
                        userId: userId,
                        imageUrl: imageUrl,
                        caption: caption,
                        timestamp: timestamp.dateValue()
                    )
                }
            }
    }
    
}
