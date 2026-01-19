//
//  FeedViewModel.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/19/26.
//

import Foundation

final class FeedViewModel: ObservableObject {
    @Published var outfits: [Outfit] = []
    
    init() {
        loadMockOutfits()
    }
    
    private func loadMockOutfits() {
        outfits = [
            Outfit(
                imageName: "outfit1",
                title: "Streetwear",
                tags: ["Street, Skater"]
            ),
            Outfit(
                imageName: "outfit2",
                title: "Old Money",
                tags: ["Classic", "Preppy", "Formal"]
            )
        ]
    }
}
