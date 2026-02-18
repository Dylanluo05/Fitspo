//
//  PostCard.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/16/26.
//

import SwiftUI

struct PostCard: View {
    
    let post: Post
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(post.title)
                .font(.title3)
                .fontWeight(.semibold)
            
            AsyncImage(url: URL(string: post.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ZStack {
                    Rectangle()
                        .fill(Color.gray.opacity(0.1))
                    ProgressView()
                }
            }
            .frame(maxHeight: 400)
            .clipped()
            .cornerRadius(12)
            
            if !post.caption.isEmpty {
                Text(post.caption)
                    .font(.body)
            }
            
            if !post.hashtags.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(post.hashtags, id: \.self) { tag in
                            Text("#\(tag)")
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 8)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}
