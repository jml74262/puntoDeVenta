//
//  purchaseView.swift
//  puntoDeVenta
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI
import Combine


 

struct purchaseView: View {
    @Environment(\.presentationMode) var  presentationMode
    @State private var productID = ""
    @State private var name = ""
    @State private var pieces = ""

    @State private var mostrarAlerta = false
    
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = SalesViewModel()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    
    
    var body: some View {
        VStack{
            Text("Purchase").font(.largeTitle).padding()
               
            
            Form{
                TextField("Product ID", text: $productID)
                           .keyboardType(.numberPad)
                           .onReceive(Just(productID)) { value in
                               let filtered = "\(value)".filter { "0123456789".contains($0) }
                               if filtered != value {
                                   self.productID = "\(filtered)"
                               }
                           }
                
                TextField("Name",text: $name)
                    .onChange(of: name) { value in
                        if !value.allSatisfy({ $0.isLetter }) {
                            name = String(value.filter { $0.isLetter })
                        }
                    }
                TextField("Pieces", text: $pieces).keyboardType(.numberPad)
                    .onReceive(Just(pieces)) { value in
                        let filtered = "\(value)".filter { "0123456789".contains($0) }
                        if filtered != value {
                            self.pieces = "\(filtered)"
                        }
                    }
                
            }.padding()
            Button("Register"){
                if !productID.isEmpty  && !name.isEmpty && !pieces.isEmpty {
                    mostrarAlerta = true
                }
                
            }.padding().alert(isPresented:$mostrarAlerta){
                Alert(title: Text("Hola"),
                message: Text("Has presionado el boton"))
            }
        }
    }
    
}





struct purchaseView_Previews: PreviewProvider {
    static var previews: some View {
        purchaseView()
    }
}
