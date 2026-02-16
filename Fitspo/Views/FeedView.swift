//
//  FeedView.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/22/26.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.posts) { post in
                        PostCard(post: post)
                    }
                }
                .padding()
            }
            .navigationTitle("Feed")
        }
    }
}
