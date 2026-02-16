//
//  FitspoApp.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/13/26.
//

import SwiftUI
import Firebase

@main
struct FitspoApp: App {
    
    @StateObject private var authViewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authViewModel)
        }
    }
}
