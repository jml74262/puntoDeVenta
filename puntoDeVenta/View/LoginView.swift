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
            ZStack{
                NavigationView{
                    GeometryReader { geometry in
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped().ignoresSafeArea(.all)
                            .scaledToFill()
                    
                    
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
                                       label: {Text("Iniciar sesion")}).font(.headline).foregroundColor(.white).background(Color(hex: 0xC3ADE6)).cornerRadius(30)
                    }.navigationTitle("").padding().position(x: 225, y: 300)
                }
                
                }
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
