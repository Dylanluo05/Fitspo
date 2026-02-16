//
//  RootView.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/9/26.
//

import Foundation
import SwiftUI

struct RootView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showRegister = false

    var body: some View {
        if authViewModel.userSession != nil {
            MainTabView()
        } else {
            if showRegister {
                RegisterView {
                    showRegister = false
                }
            } else {
                LoginView {
                    showRegister = true
                }
            }
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AuthViewModel())
}
