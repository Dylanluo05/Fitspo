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
            Group {
                if viewModel.posts.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        
                        Text("No posts yet")
                            .font(.headline)
                        
                        Text("Be the first to share a fit inspo")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.posts) { post in
                                PostCard(post: post)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Explore")
            .toolbar {
                NavigationLink(destination: CreatePostView()) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
