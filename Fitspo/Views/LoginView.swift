//
//  LoginView.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/23/26.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    let showRegister: () -> Void
    
    @State private var identifier = ""
    @State private var password = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Log In")
                .font(.largeTitle)
                .bold()
            
            TextField("Email or Username", text: $identifier)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            if let error = authViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button("Log In") {
                authViewModel.login(identifier: identifier, password: password)
            }
            .buttonStyle(.borderedProminent)
            
            Button("Create an account") {
                showRegister()
            }
            
            Spacer()
        }
        .padding()
    }
}
