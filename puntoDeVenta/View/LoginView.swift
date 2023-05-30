//
//  LoginView.swift
//  puntoDeVenta
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding().textInputAutocapitalization(.never)
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding().textInputAutocapitalization(.none)
            
            Button(action: {
                login()
            }) {
                Text("Log In")
            }
            
            Button(action: {
                register()
            }) {
                Text("Register")
            }
        }
        .padding()
        .fullScreenCover(isPresented: $isLoggedIn) {
                  MenuView()
              }
    }
    
    private func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                // Manejo del error de inicio de sesión
                print("Error logging in: \(error.localizedDescription)")
            } else {
                // Inicio de sesión exitoso
                print("Logged in successfully.")
                isLoggedIn = true
            }
        }
    }
    
    private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                // Manejo del error de registro
                print("Error registering user: \(error.localizedDescription)")
            } else {
                // Registro exitoso
                print("User registered successfully.")
               
            }
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
