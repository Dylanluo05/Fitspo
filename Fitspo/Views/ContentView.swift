//
//  ContentView.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/13/26.
//

import SwiftUI

struct ContentView: View {
    let outfits = [
        Outfit(imageName: "outfit1", title: "Streetwear", tags: ["Street", "Casual"]),
        Outfit(imageName: "outfit2", title: "Old Money", tags: ["Classic", "Formal"])
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(outfits) {
                        outfit in OutfitCardView(outfit: outfit)
                    }
                }
                .padding()
            }
            .navigationTitle("Inspiration")
        }
    }
}

#Preview {
    ContentView()
}
