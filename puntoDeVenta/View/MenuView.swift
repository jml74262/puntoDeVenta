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
    @State var presentEditMovieSheet = false
    @State var registro = false
    @State var productos = false
    @State var ventas = false
    @State var compras = false
    
    var body: some View {
        NavigationView {
            ZStack {
                GeometryReader { geometry in
                    Image("ss2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .ignoresSafeArea(.all)
                        .scaledToFill()
                }
                
                VStack {
                    if registro {
                        CustomNavLink(text: "Register", view: Menu2View())
                    }
                    
                    if ventas {
                        CustomNavLink(text: "Sales", view: SaleListView())
                    }
                    
                    if compras {
                        CustomNavLink(text: "Purchase", view: PurchaseListView())
                    }
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
                        registro = true
                        productos = true
                        ventas = true
                        compras = false
                    } else if role == "User" {
                        registro = false
                        productos = false
                        ventas = false
                        compras = true
                    }
                }
            }
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
                    .frame(width: 150, height: 30, alignment: .center)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: 0xC3ADE6))
                    .cornerRadius(10)
            }
        }
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
