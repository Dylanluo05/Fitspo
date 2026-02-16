//
//  AuthService.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/25/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    @Published private(set) var userSession: FirebaseAuth.User?
    
    private init() {
        userSession = auth.currentUser
        listenToAuthChanges()
    }
    
    private func listenToAuthChanges() {
        authStateHandle = auth.addStateDidChangeListener { _, user in
            self.userSession = user
        }
    }
    
    deinit {
        if let handle = authStateHandle {
            auth.removeStateDidChangeListener(handle)
        }
    }
    
    func register(email: String, username: String, fullName: String, dateOfBirth: Date, password: String, completion: @escaping (Error?) -> Void) {
        let normalizedEmail = email.lowercased()
        let normalizedUsername = username.lowercased()
        
        auth.createUser(withEmail: normalizedEmail, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let uid = result?.user.uid else {
                completion(nil)
                return
            }
            
            let userData: [String: Any] = [
                "uid": uid,
                "email": normalizedEmail,
                "username": normalizedUsername,
                "fullName": fullName,
                "dateOfBirth": Timestamp(date: dateOfBirth),
                "createdAt": Timestamp()
            ]
            
            self.db.collection("users")
                .document(uid)
                .setData(userData) { error in
                    completion(error)
                }
        }
    }
    
    func login(identifier: String, password: String, completion: @escaping (Error?) -> Void) {
        
        let normalized = identifier
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        if normalized.contains("@") {
            auth.signIn(withEmail: normalized, password: password) { _, error in
                completion(error)
            }
        } else {
            loginWithUsername(username: normalized, password: password, completion: completion)
        }
    }
    
    private func loginWithUsername(
        username: String,
        password: String,
        completion: @escaping (Error?) -> Void
    ) {
        db.collection("users")
            .whereField("username", isEqualTo: username)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                if let error {
                    completion(error)
                    return
                }
                
                guard
                    let document = snapshot?.documents.first,
                    let email = document.data()["email"] as? String
                else {
                    completion(NSError(
                        domain: "",
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: "Username not found"]
                    ))
                    return
                }
                
                self.auth.signIn(withEmail: email, password: password) { _, error in
                    completion(error)
                }
        }
    }
    
    func fetchCurrentUser(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        guard let uid = userSession?.uid else { return }
        
        db.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = snapshot?.data() {
                completion(.success(data))
            }
        }
    }
    
    func logout() {
        try? auth.signOut()
        userSession = nil
    }
}
