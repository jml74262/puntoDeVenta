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
                    NavigationLink(destination: Menu2View(),
                                   label: {Text("Register ")}).padding(.all)
                    NavigationLink(destination: SaleListView(),
                                   label: {Text("Sales ")}).padding(.all)
                
                    NavigationLink(destination: PurchaseListView(),
                                   label: {Text("Purchase ")}).padding(.all)
                }.padding().navigationTitle("").padding(.all)
            }.navigationViewStyle(StackNavigationViewStyle())
        }
    }

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
