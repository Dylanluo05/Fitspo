//
//  AppViewModel.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/22/26.
//

import Foundation

final class AppViewModel: ObservableObject {
    @Published var outfits: [Outfit] = []
    
    init() {
        loadMockOutfits()
    }
    
    var savedOutfits: [Outfit] {
        outfits.filter { $0.isSaved }
    }
    
    func toggleSave(for outfit: Outfit) {
        guard let index = outfits.firstIndex(where: { $0.id == outfit.id }) else { return }
        outfits[index].isSaved.toggle()
    }
    
    private func loadMockOutfits() {
        outfits = [
            Outfit(imageName: "outfit1", title: "Streetwear", tags: ["Street", "Skater"]),
            Outfit(imageName: "outfit2", title: "Old Money", tags: ["Classic", "Preppy", "Formal"])
        ]
    }
}
