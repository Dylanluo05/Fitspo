//
//  AuthView.swift
//  Fitspo
//
//  Created by Dylan Luo on 2/9/26.
//

import Foundation
import SwiftUI

struct AuthView: View {
    
    @State private var showingRegister = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if showingRegister {
                    RegisterView {
                        showingRegister = false
                    }
                } else {
                    LoginView {
                        showingRegister = true
                    }
                }
            }
        }
    }
}
