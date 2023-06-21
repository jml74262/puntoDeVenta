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
            NavigationView {
            ZStack{
                    Image("ss2")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                VStack{
                   
                    CustomNavLink(text: "User", view: UserListView())
                        .navigationBarBackButtonHidden(true)
                        .navigationViewStyle(.stack)
                   CustomNavLink(text: "Product", view: ProductListView())
                        .navigationBarBackButtonHidden(true)
                        .navigationViewStyle(.stack)
                }.navigationTitle("")
                    .padding(EdgeInsets( top: 100, leading: 0, bottom: 5, trailing: 10))
                    .navigationViewStyle(StackNavigationViewStyle())
                    
                    
            }
                
            }
            
        }
        
    }
    struct CustomNavLink<Destination: View>: View {
        let text: String
        let view: Destination
        
        var body: some View {
            NavigationLink(destination: view) {
                Text(text)
                    .foregroundColor(.white)
                    .padding(EdgeInsets( top: 40, leading: 50, bottom: 10, trailing: 10)) // Add the desired padding here
            }
        }
    }
}


struct Menu2View_Previews: PreviewProvider {
    static var previews: some View {
        Menu2View()
    }
}
