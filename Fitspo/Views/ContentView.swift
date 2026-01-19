//
//  ContentView.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/13/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(viewModel.outfits) {
                        outfit in OutfitCardView(outfit: outfit)
                    }
                }
                .padding()
            }
            .navigationTitle("Inspiration")
        }
    }
}
