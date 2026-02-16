//
//  AuthViewModel.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/23/26.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class AuthViewModel: ObservableObject {

    @Published var userSession: FirebaseAuth.User?
    @Published var errorMessage: String?

    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    private var authStateHandle: AuthStateDidChangeListenerHandle?

    init() {
        userSession = auth.currentUser
        listenToAuthChanges()
    }

    // MARK: - Auth State Listener
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

    // MARK: - Login (Email OR Username)
    func login(identifier: String, password: String) {
        errorMessage = nil

        let normalized = identifier
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if normalized.contains("@") {
            auth.signIn(withEmail: normalized, password: password) { _, error in
                if let error {
                    self.errorMessage = error.localizedDescription
                }
            }
        } else {
            loginWithUsername(username: normalized, password: password)
        }
    }

    private func loginWithUsername(username: String, password: String) {
        db.collection("users")
            .whereField("username", isEqualTo: username)
            .limit(to: 1)
            .getDocuments { snapshot, error in
                if let error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                guard
                    let document = snapshot?.documents.first,
                    let email = document.data()["email"] as? String
                else {
                    self.errorMessage = "Username not found"
                    return
                }

                self.auth.signIn(withEmail: email, password: password) { _, error in
                    if let error {
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
    }

    // MARK: - Register
    func register(
        email: String,
        username: String,
        fullName: String,
        dateOfBirth: Date,
        password: String
    ) {
        errorMessage = nil

        let normalizedEmail = email.lowercased()
        let normalizedUsername = username.lowercased()

        auth.createUser(withEmail: normalizedEmail, password: password) { result, error in
            if let error = error {
                print("AUTH ERROR:", error)
                self.errorMessage = error.localizedDescription
                return
            }

            guard let uid = result?.user.uid else { return }

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
                    if let error {
                        self.errorMessage = error.localizedDescription
                    }
                }
        }
    }

    // MARK: - Logout
    func logout() {
        try? auth.signOut()
        userSession = nil
    }
}
