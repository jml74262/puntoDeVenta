//
//  SalesView.swift
//  puntoDeVenta
//
//  Created by ISSC_611_2023 on 26/04/23.
//

import SwiftUI
import Combine

struct SalesView: View {
    @State private var SaleId = ""
    @State private var name = ""
    @State private var cantidad = ""
    @State private var IdVentas = ""
    @State private var IdComprador = ""
    @State private var precio = ""
    @State private var subtotal = ""
    @State private var total = ""
    @State private var mensaje = ""
    @State var onlyNumbersValue: String = ""
    @State private var mostrarAlerta = false
    @State private var mostrarLogin = false
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Registro de Productos")
                Form{
                    TextField("ID",text: $SaleId).keyboardType(.numberPad)
                        .onReceive(Just(SaleId)) { value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.SaleId = "\(filtered)"
                            }
                        }
                    TextField("Nombre",text: $name).onChange(of: name) { value in
                        if !value.allSatisfy({ $0.isLetter }) {
                            name = String(value.filter { $0.isLetter })
                        }
                    }
                    
                    
                    TextField("Cantidad",text: $onlyNumbersValue).keyboardType(.numberPad).onReceive(Just(onlyNumbersValue)) { value in
                        let filtered = "\(value)".filter { "0123456789".contains($0) }
                        if filtered != value {
                            self.onlyNumbersValue = "\(filtered)"
                        }
                    }
                    TextField("IdVentas",text: $IdVentas)
                    TextField("IdComprador",text: $IdComprador)
                    TextField("Precio",text: $precio)
                    TextField("Subtotal",text: $subtotal)
                    TextField("Total",text: $total)
                    
                }.padding()
                
                Button("Venta"){
                    
                    
                    
                }.padding().alert(isPresented: $mostrarAlerta){
                    Alert(title: Text("Alerta"),message:Text("\(mensaje)"),dismissButton: .default(Text("Ok")))
                }
                
                
            }
        }
    }
}
struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView()
    }
}
