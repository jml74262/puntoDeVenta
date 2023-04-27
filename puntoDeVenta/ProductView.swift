//
//  ProductView.swift
//  puntoDeVenta
//
//  Created by ISSC_611_2023 on 26/04/23.
//


import SwiftUI

struct ProductView: View {
    
    @State private var id = ""
    @State private var nombre = ""
    @State private var descripcion = ""
    @State private var unidades = ""
    @State private var costo = ""
    @State private var precio = ""
    @State private var utilidad = ""
    @State private var mensaje = ""
    @State private var mostrarAlerta = false
    @State private var mostrarLogin = false
    var body: some View {
        
            NavigationView {
                VStack{
                    Text("Registro de Productos")
                    Form{
                        TextField("ID",text: $id)
                        TextField("Nombre",text: $nombre)
                        TextField("Descripción",text: $descripcion)
                        
                        TextField("Unidades",text: $unidades)
                        TextField("Costo",text: $costo)
                        TextField("Precio",text: $precio)
                        TextField("Utilidad",text: $utilidad)
                    }.padding()
                    
                    Button("Alta de Producto"){
                        
                  
                      
                    }.padding().alert(isPresented: $mostrarAlerta){
                        Alert(title: Text("Alerta"),message:Text("\(mensaje)"),dismissButton: .default(Text("Ok")))
                    }
                    
                 
                }
            }
        }
        
        @Environment(\.presentationMode) var presentationMode
    }


struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
