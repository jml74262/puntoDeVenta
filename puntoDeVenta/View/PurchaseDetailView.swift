//
//  PurchaseDetailView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 19/05/23.
//

import SwiftUI

struct PurchaseDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMovieSheet = false
     
    var purchase: Purchase
     
    private func editButton(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
        Text("Edit")
      }
    }
     
    var body: some View {
      Form {
        Section(header: Text("Purchase")) {
            Text(purchase.name).bold()
            Text(String(purchase.pieces)).bold()
        }
      }
      .cornerRadius(40)
      .background(Color.clear)
      .navigationBarTitle(purchase.name)
      .navigationBarItems(trailing: editButton {
        self.presentEditMovieSheet.toggle()
      })
      .onAppear() {
        print("PurchaseDetailView.onAppear() for \(self.purchase.name)")
      }
      .onDisappear() {
        print("PurchaseDetailView.onDisappear()")
      }
      .sheet(isPresented: self.$presentEditMovieSheet) {
        PurchaseEditView(viewModel: PurchaseViewModel(purchase: purchase), mode: .edit) { result in
          if case .success(let action) = result, action == .delete {
            self.presentationMode.wrappedValue.dismiss()
          }
        }
      }
      .foregroundColor(Color(hex: 0xC3ADE6))
      .background(Image("rosa"))
    }
     
  }

struct PurchaseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let purchase = Purchase(name: "", pieces: 1)
        return
          NavigationView {
            PurchaseDetailView(purchase: purchase)
          }
    }

}
