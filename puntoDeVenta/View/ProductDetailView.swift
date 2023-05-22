//
//  ProductDetailView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 19/05/23.
//

import SwiftUI

struct ProductDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMovieSheet = false
     
    var product: Product
     
    private func editButton(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
        Text("Edit")
      }
    }
     
    var body: some View {
      Form {
        Section(header: Text("Product")) {
            Text(product.name).bold()
            Text(product.description).bold()
            Text(String(product.cost)).bold()
            Text(String(product.price)).bold()
            Text(String(product.units)).bold()
            Text(String(product.utility)).bold()
           
            
            
        }
      }
      .cornerRadius(40)
      .background(Color.clear) // Establece el fondo del Form como transparente
      .padding()
      .navigationBarTitle(product.name)
      .navigationBarItems(trailing: editButton {
        self.presentEditMovieSheet.toggle()
      })
      .onAppear() {
        print("ProductDetailView.onAppear() for \(self.product.name)")
      }
      .onDisappear() {
        print("ProductDetailView.onDisappear()")
      }
      .sheet(isPresented: self.$presentEditMovieSheet) {
        ProductEditView(viewModel: ProductViewModel(product: product), mode: .edit) { result in
          if case .success(let action) = result, action == .delete {
            self.presentationMode.wrappedValue.dismiss()
          }
        }
      }
      .foregroundColor(Color(hex: 0xC3ADE6))
      .background(Image("rosa"))
      
        
    }
     
  }
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let product = Product(name: "pay", description: "pay de queso", cost: 4.0, price: 9.0, units: 6, utility: 5.0)
        return
          NavigationView {
            ProductDetailView(product: product)
          }
    }
}
