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
            
            AsyncImage(url: URL(string: post.imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(maxHeight: 400)
            .clipped()
            .cornerRadius(12)
            
            Text(post.caption)
                .font(.body)
        }
    }
    
}
