//
//  UserView.swift
//  puntoDeVenta
//
//  Created by ISSC_611_2023 on 26/04/23.
//
import SwiftUI
import Combine
struct UserView: View {
    @State private var name = ""
    @State private var apellido = ""
    @State private var edad = 0
    @State private var genero = ""
    @State private var email = ""
    @State private var contraseña = ""
    @State private var rol = ""
    @State var onlyNumbersValue: String = ""
   
     var body: some View {
        NavigationView {
        VStack {
            Text("User")
                .font(.largeTitle)
                .padding(EdgeInsets(top: 1, leading: 62, bottom: 3, trailing: 25))
                                  .font(.callout)
                                  .foregroundColor(Color(hex: 0x964B00)) // Cambiar el color del texto a café
                                  .padding()
                                  .cornerRadius(10)
            Form{
                
                TextField("Name", text: $name).onChange(of: name) { value in
                    if !value.allSatisfy({ $0.isLetter }) {
                        name = String(value.filter { $0.isLetter })
                    }
                }
                TextField("Last Name", text: $apellido).onChange(of: apellido) { value in
                    if !value.allSatisfy({ $0.isLetter }) {
                        apellido = String(value.filter { $0.isLetter })
                    }
                }
                TextField("Age", text: $onlyNumbersValue)
                        .keyboardType(.numberPad)
                        .onReceive(Just(onlyNumbersValue)) { value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.onlyNumbersValue = "\(filtered)"
                            }
                        }
                    
                
                TextField("Gender", text: $genero).onChange(of: genero) { value in
                    if !value.allSatisfy({ $0.isLetter }) {
                        genero = String(value.filter { $0.isLetter })
                    }
                }
                TextField("Email", text: $email)
                
                SecureField("Password", text: $contraseña)
                TextField("Role", text: $rol).onChange(of: rol) { value in
                    if !value.allSatisfy({ $0.isLetter }) {
                        rol = String(value.filter { $0.isLetter })
                    }
                }
                
                
            }
         
            Button("Registrar"){
                        
                    }
        }
        
        .padding()
    }
  }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
