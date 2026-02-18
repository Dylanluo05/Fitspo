//
//  Post.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/16/26.
//

import Foundation

struct Post: Identifiable {
    let id: String
    let userId: String
    let title: String
    let imageUrl: String
    let caption: String
    let hashtags: [String]
    let timestamp: Date
}
