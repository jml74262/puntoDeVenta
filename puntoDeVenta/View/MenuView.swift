//
//  MenuView.swift
//  puntoDeVenta
//
//  Created by ISSC_611_2023 on 24/04/23.
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI
import Firebase

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var registro = false
    @State var productos = false
    @State var ventas = false
    @State var compras = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("menu")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    if registro {
                        CustomNavLink(text: "Register", view: UserListView())
                            
                    }
                    if productos {
                        CustomNavLink(text: "Products", view: ProductListView())
                    }
                    
                    if ventas {
                        CustomNavLink(text: "Sales", view: SaleListView())
                    }
                    
                    if compras {
                        CustomNavLink(text: "Purchase", view: PurchaseListView())
                    }
                    
                    Spacer().frame(height: 10)
                    
                    Button(action: signOut) {
                        Text("Cerrar sesión")
                            .font(.callout)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                            
                    }.frame(width: 150, height: 25, alignment: .bottom)
                        .offset(y: 130)
                    
                }
            }
        }
        .onAppear {
            roles()
        }
        .navigationTitle("Menu")
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func roles() {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            let userRef = db.collection("user").document(user.uid)
            
            userRef.getDocument { (snapshot, error) in
                if let error = error {
                    print("Error fetching user document: \(error)")
                    return
                }
                
                if let snapshot = snapshot, snapshot.exists {
                    let role = snapshot.get("role") as? String
                    print(role ?? "")
                    
                    if role == "Admin" {
                        registro = true
                        productos = true
                        ventas = true
                        compras = true
                    } else if role == "Seller" {
                        registro = false
                        productos = false
                        ventas = true
                        compras = false
                    } else if role == "User" {
                        registro = false
                        productos = false
                        ventas = true
                        compras = false
                    }
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            presentationMode.wrappedValue.dismiss()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}

struct CustomNavLink<Destination: View>: View {
    let text: String
    let view: Destination
    
    var body: some View {
        VStack {
            NavigationLink(destination: view) {
                Text(text)
                                  .font(.callout)
                                  .foregroundColor(.white)
                                  .padding()
                                  .background(Color.clear)
                                  .cornerRadius(10)
            }
            .buttonStyle(NavLinkButtonStyle())

        }
    }
}

struct NavLinkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 7, leading: 12, bottom: 8, trailing: 12))
            .multilineTextAlignment(.center)
            .background(configuration.isPressed ? Color.clear : Color.clear)
            .cornerRadius(10)
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}






struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
