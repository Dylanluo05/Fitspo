//
//  OutfitCardView.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/13/26.
//

import Foundation
import SwiftUI

struct OutfitCardView: View {
    let outfit: Outfit
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Image(outfit.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 280)
                    .clipped()
                    .cornerRadius(12)
                
                Image(systemName: "bookmark")
                    .padding(10)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .padding()
            }
            
            Text(outfit.title)
                .font(.headline)
            
            HStack {
                ForEach(outfit.tags, id: \.self) {
                    tag in Text(tag)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                }
            }
        }
    }
}
