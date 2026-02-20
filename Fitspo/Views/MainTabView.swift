//
//  MainTabView.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/9/26.
//

import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            FeedView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explore")
                }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
            
            DetectionView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Analysis")
                }
        }
    }
}
