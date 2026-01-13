//
//  Outfit.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/13/26.
//

import Foundation
struct Outfit: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let tags: [String]
}
