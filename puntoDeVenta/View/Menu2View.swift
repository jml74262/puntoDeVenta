//
//  Menu2View.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 21/05/23.
//

import SwiftUI

struct Menu2View: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMovieSheet = false
    
    var mode: Mode = .new
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                Image("ss2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .ignoresSafeArea(.all)
                    .scaledToFill()
            }

            
            
            VStack{
               
                NavigationLink(destination: UserListView(),
                               label: {Text("User")}).padding()
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: 0xC3ADE6))
                    .cornerRadius(10).position(x: 205, y: 200)
            
                NavigationLink(destination: ProductListView(),
                               label: {Text("Product ")}).padding()
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: 0xC3ADE6))
                    .cornerRadius(10)
                    .position(x: 205, y: 5)
            }.navigationTitle("")
                
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        
            
       
        
    
    }
}

struct Menu2View_Previews: PreviewProvider {
    static var previews: some View {
        Menu2View()
    }
}
