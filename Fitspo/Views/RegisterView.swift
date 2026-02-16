//
//  RegisterView.swift
//  Fitspo
//
//  Created by Dylan Luo on 1/25/26.
//

import Foundation
import SwiftUI

struct RegisterView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    let showLogin: () -> Void

    @State private var email = ""
    @State private var username = ""
    @State private var fullName = ""
    @State private var dateOfBirth = Date()
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack(spacing: 12) {
            Text("Create Account")
                .font(.largeTitle)
                .bold()

            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)

            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)

            TextField("Full Name", text: $fullName)
                .textFieldStyle(.roundedBorder)

            DatePicker(
                "Date of Birth",
                selection: $dateOfBirth,
                displayedComponents: .date
            )

            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()

            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()

            if let error = authViewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
            }

            Button("Register") {
                guard password == confirmPassword else {
                    authViewModel.errorMessage = "Passwords do not match"
                    return
                }

                authViewModel.register(
                    email: email,
                    username: username,
                    fullName: fullName,
                    dateOfBirth: dateOfBirth,
                    password: password
                )
            }
            .buttonStyle(.borderedProminent)

            Button("Already have an account? Log in") {
                showLogin()
            }

            Spacer()
        }
        .padding()
    }
}
