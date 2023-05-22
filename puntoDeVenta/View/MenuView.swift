//
//  MenuView.swift
//  puntoDeVenta
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI
struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMovieSheet = false
    @State var isValid = false
    
    var body: some View {
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
                NavigationLink(destination: Menu2View(), isActive: $isValid) {
                    Text("Register")
                        .frame(width: 150, height: 30, alignment: .center)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(hex: 0xC3ADE6))
                        .cornerRadius(10)
                        
                    
                }
                .padding()
                
                NavigationLink(destination: SaleListView()) {
                    Text("Sales")
                        .frame(width: 150, height: 30, alignment: .center)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(hex: 0xC3ADE6))
                        .cornerRadius(10)
                       
                }
                .padding()
                
                NavigationLink(destination: PurchaseListView()) {
                    Text("Purchase")
                        .frame(width: 150, height: 30, alignment: .center)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(hex: 0xC3ADE6))
                        .cornerRadius(10)
                        
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top).position(x: 220, y: 490)
        }
        .navigationTitle("")
        .navigationViewStyle(StackNavigationViewStyle())
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
