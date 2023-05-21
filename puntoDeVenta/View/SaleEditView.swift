//
//  SaleEditView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 21/05/23.
//

import SwiftUI
import UIKit

struct SaleEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = SaleVieModel()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
     
     
    var cancelButton: some View {
      Button(action: { self.handleCancelTapped() }) {
        Text("Cancel")
      }
    }
     
    var saveButton: some View {
      Button(action: { self.handleDoneTapped() }) {
        Text(mode == .new ? "Done" : "Save")
      }
      .disabled(!viewModel.modified)
    }
     
    var body: some View {
      NavigationView {
        Form {
          Section(header: Text("Sale")) {
              
              
              
              TextField("Name", text: $viewModel.sale.name).onChange(of: viewModel.sale.name) { value in
                if !value.allSatisfy({ $0.isLetter }) {
                    viewModel.sale.name = String(value.filter { $0.isLetter })
                }}
            TextField("IdClient", text: $viewModel.sale.idClient)
              TextField("IdClient", text: $viewModel.sale.idProduct)
              TextField("Pieces", text: Binding<String>(
                         get: { String(describing: viewModel.sale.pieces) },
                         set: { viewModel.sale.pieces = Int($0) ?? 0 }
                     ))
              TextField("subtotal", text: Binding<String>(
                         get: { String(describing: viewModel.sale.subtotal) },
                         set: { viewModel.sale.subtotal = Double($0) ?? 0 }
                     ))
              TextField("total", text: Binding<String>(
                get: { String(describing: viewModel.sale.total) },
                         set: { viewModel.sale.total = Double($0) ?? 0 }
                     ))
          }
           

           
          if mode == .edit {
            Section {
              Button("Delete sale") { self.presentActionSheet.toggle() }
                .foregroundColor(.red)
            }
          }
        }
        .navigationTitle(mode == .new ? "New sale" : viewModel.sale.name)
        .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
        .navigationBarItems(
          leading: cancelButton,
          trailing: saveButton
        )
        .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete Sale"),
                                     action: { self.handleDeleteTapped() }),
                        .cancel()
                      ])
        }
      }
    }
     
    // Action Handlers
     
    func handleCancelTapped() {
      self.dismiss()
    }
     
    func handleDoneTapped() {
      self.viewModel.handleDoneTapped()
      self.dismiss()
    }
     
    func handleDeleteTapped() {
      viewModel.handleDeleteTapped()
      self.dismiss()
      self.completionHandler?(.success(.delete))
    }
     
    func dismiss() {
      self.presentationMode.wrappedValue.dismiss()
    }
  }
 
struct SaleEditView_Previews: PreviewProvider {
    static var previews: some View {
        SaleEditView()
    }
}
