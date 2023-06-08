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
    init(){
        UITextField.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack{
            Image("login")
                         .resizable()
                         .scaledToFill()
                         .edgesIgnoringSafeArea(.all) //
            VStack {
                Text("Welcome back, you've been missed!")
                    .foregroundColor(.black)
                    .font(.footnote)
                let fondo = Color(red: 0.972, green: 0.996, blue: 0.941)
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .cornerRadius(10)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .background(Color.clear)
                    .cornerRadius(10)
                    .textContentType(.password)
                    .autocapitalization(.none)
                
                Button(action: {
                    login()
                }) {
                    let customColor = Color(red: 0.478, green: 0.416, blue: 0.325)
                    Text("Sign in")
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
                        .background(customColor)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(customColor, lineWidth: 2)
                        )
                }.padding(EdgeInsets(top: 60, leading: 20, bottom: 10, trailing: 20))
                
            }
            .padding()
            .fullScreenCover(isPresented: $isLoggedIn) {
                MenuView()
            }
           
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
    
  /*  private func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                // Manejo del error de registro
                print("Error registering user: \(error.localizedDescription)")
            } else {
                // Registro exitoso
                print("User registered successfully.")
               
            }
        }
    }*/
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
