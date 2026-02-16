//
//  HomeViewModel.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/12/26.
//

import Foundation
import FirebaseFirestore

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var errorMessage: String?
    
    private let db = Firestore.firestore()
    
    func getUsers() {
        db.collection("users")
            .order(by: "createdAt", descending: true)
            .getDocuments { snapshot, error in
                
                if let error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                
                guard let documents = snapshot?.documents else { return }
                
                self.users = documents.compactMap { User(from: $0) }
            }
    }
}
