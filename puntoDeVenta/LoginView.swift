//
//  LoginView.swift
//  puntoDeVenta
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI

struct LoginView: View {
    @State private var user = ""
        @State private var namet = "Dani"
        @State private var email = ""
        @State private var password = ""
        @State private var passwordt = "12345"
        @State private var mostrarAlerta = true
        @State private var isValid = false
        var body: some View {
            NavigationView{
                VStack{
                    Form{
                            TextField("User", text: $user)
                            SecureField("Password", text: $password)
                    }.frame(width: 280 , height: 150)
                        .onSubmit{
                        validateForm()
                    }.onSubmit {
                        validateForm()
                    }
                    NavigationLink(destination: MenuView(),
                    isActive: $isValid,
                    label: {Text("Iniciar sesion")}).disabled(!isValid)
                }.navigationTitle("").padding()
            }
        }
        private func validateForm() {
               isValid = !user.isEmpty && !password.isEmpty && user == namet && password == passwordt
           }
    }

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
