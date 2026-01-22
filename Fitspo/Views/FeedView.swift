//
//  FeedView.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/22/26.
//

import Foundation
import SwiftUI

struct FeedView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(appViewModel.outfits) {
                        outfit in OutfitCardView(outfit: outfit)
                    }
                }
                .padding()
            }
            .navigationTitle("Inspiration")
        }
    }
}
