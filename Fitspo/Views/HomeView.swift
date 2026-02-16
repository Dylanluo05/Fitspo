//
//  HomeView.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/12/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.users) { user in
                VStack(alignment: .leading) {
                    Text(user.fullName)
                        .font(.headline)
                    
                    Text("@\(user.username)")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                    
                    Text(user.email)
                        .font(.caption)
                }
            }
            .navigationTitle("Fitspo Users")
            .onAppear {
                viewModel.getUsers()
            }
        }
    }
}
