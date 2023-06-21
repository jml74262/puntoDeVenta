//
//  SaleDetailView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 21/05/23.
//

import SwiftUI

struct SaleDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMovieSheet = false
     
    var sale: Sale
     
    private func editButton(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
        Text("Edit")
      }
    }
     
    var body: some View {
      Form {
        Section(header: Text("Sale")) {
            Text(sale.name).bold()
            Text(sale.IdClient).bold()
            Text(sale.IdProduct).bold()
            Text(String(sale.pieces)).bold()
            Text(String(sale.subtotal)).bold()
            Text(String(sale.total)).bold()
            
            
        }
      }
      .cornerRadius(40)
      .background(Color.clear)
      .navigationBarTitle(sale.name)
      .navigationBarItems(trailing: editButton {
        self.presentEditMovieSheet.toggle()
      })
      .onAppear() {
        print("UserDetailView.onAppear() for \(self.sale.name)")
      }
      .onDisappear() {
        print("UserDetailView.onDisappear()")
      }
      .sheet(isPresented: self.$presentEditMovieSheet) {
            SaleEditView(viewModel: SaleVieModel(sale: sale), mode: .edit) { result in
              if case .success(let action) = result, action == .delete {
                self.presentationMode.wrappedValue.dismiss()
              }
            }
          }.foregroundColor(Color(hex: 0x964B00))
                .background(Image("rosa"))
    }
     
  }
struct SaleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sale = Sale(IdClient: "sadsadsa", IdProduct: "hfgd", name: "pan", subtotal: 0, total: 0, pieces: 0)
        return
          NavigationView {
            SaleDetailView(sale: sale)
          }
    }
}
