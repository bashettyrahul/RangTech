//
//  RegistrationView.swift
//  RangTech
//
//  Created by Rahul Bashetty on 18/08/24.
//

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                let user = User(email: email, password: password)
                AuthService.shared.register(user: user) { result in
                    switch result {
                    case .success:
                        
                        errorMessage = "Registration successful"
                        showingAlert = true
                    case .failure(let error):
                        
                        errorMessage = error.localizedDescription
                        showingAlert = true
                    }
                }
            }) {
                Text("Register")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Registration"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
