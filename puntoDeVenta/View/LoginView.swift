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
                        
                        TextField("User", text: $user).frame(width: 230, height: 50, alignment: .center).font(.body).foregroundColor(.white).background(.white).cornerRadius(10)
                        SecureField("Password", text: $password).frame(width: 230, height: 50, alignment: .center).font(.body).foregroundColor(.white).background(.white).cornerRadius(10).padding()
                        
                        NavigationLink(destination: MenuView(),
                        isActive: $isValid,
                                       label: {Text("Iniciar sesion").padding().font(.body)}).font(.headline).foregroundColor(.white).background(Color(hex: 0xC3ADE6)).cornerRadius(30).padding()
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
