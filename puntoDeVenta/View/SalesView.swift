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
                    TextField("IdVentas",text: $IdVentas).keyboardType(.numberPad)
                        .onReceive(Just(IdVentas)) { value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.IdVentas = "\(filtered)"
                            }
                        }
                    TextField("IdComprador",text: $IdComprador).keyboardType(.numberPad)
                        .onReceive(Just(IdComprador)) { value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.IdComprador = "\(filtered)"
                            }
                        }
                    TextField("Precio",text: $precio).keyboardType(.numberPad)
                        .onReceive(Just(precio)) { value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.precio = "\(filtered)"
                            }
                        }
                    TextField("Subtotal",text: $subtotal).keyboardType(.numberPad)
                        .onReceive(Just(subtotal)) { value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.subtotal = "\(filtered)"
                            }
                        }
                    TextField("Total",text: $total).keyboardType(.numberPad)
                        .onReceive(Just(total)) { value in
                            let filtered = "\(value)".filter { "0123456789".contains($0) }
                            if filtered != value {
                                self.total = "\(filtered)"
                            }
                        }
                    
                }.padding()
                
                Button("Venta"){
                    
                    
                    
                }.padding().alert(isPresented: $mostrarAlerta){
                    Alert(title: Text("Alerta"),message:Text("\(mensaje)"),dismissButton: .default(Text("Ok")))
                }
                
                
            }
           
        }
        .foregroundColor(Color(hex: 0xC3ADE6))
        .navigationBarTitleDisplayMode(.inline)
    }
}
struct SalesView_Previews: PreviewProvider {
    static var previews: some View {
        SalesView()
    }
}
