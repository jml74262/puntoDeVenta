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
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink(destination: UserListView(),
                               label: {Text("User")}).padding(.all)
            
                NavigationLink(destination: ProductListView(),
                               label: {Text("Product ")}).padding(.all)
            }.padding().navigationTitle("").padding(.all)
        }
    }
}

struct Menu2View_Previews: PreviewProvider {
    static var previews: some View {
        Menu2View()
    }
}
