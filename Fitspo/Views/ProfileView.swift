//
//  ProfileView.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/22/26.
//

import Foundation
import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showLogoutAlert = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                Text("Profile")
                    .font(.largeTitle)
                    .bold()
                
                Button(role: .destructive) {
                    showLogoutAlert = true
                } label: {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .alert("Are you sure you want to log out?",
                   isPresented: $showLogoutAlert) {
                Button("Log Out", role: .destructive) {
                    authViewModel.logout()
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}
