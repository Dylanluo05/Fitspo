//
//  ProfileView.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/22/26.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if appViewModel.savedOutfits.isEmpty {
                    Text("No saved outfits yet")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    VStack(spacing: 20) {
                        ForEach(appViewModel.savedOutfits) {
                            outfit in OutfitCardView(outfit: outfit)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Saved")
        }
    }
}
