//
//  MenuView.swift
//  puntoDeVenta
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var  presentationMode
        var body: some View {
            NavigationView{
                VStack{
                    Button("Register"){
                    }.padding(.all)
                    Button("Sales"){
    
                    }.padding(.all)
                    NavigationLink(destination: purchaseView(),
                                   label: {Text("Purchase ")}).padding(.all)
                }.padding().navigationTitle("").padding(.all)
            }
        }
    }

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
