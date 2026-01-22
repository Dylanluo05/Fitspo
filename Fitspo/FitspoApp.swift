//
//  FitspoApp.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/13/26.
//

import SwiftUI

@main
struct FitspoApp: App {
    @StateObject private var appViewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                FeedView().tabItem {
                    Label("Feed", systemImage: "house")
                }
                
                ProfileView().tabItem {
                    Label("Profile", systemImage: "person")
                }
            }
            .enviromentObject(appViewModel)
        }
    }
}
