//
//  PurchaseEditView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 19/05/23.
//

import SwiftUI

struct PurchaseEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = PurchaseViewModel()
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
          Section(header: Text("Purchase")) {
              TextField("Name", text: $viewModel.purchase.name).onChange(of: viewModel.purchase.name) { value in
                  if !value.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
                    viewModel.purchase.name = String(value.filter { $0.isLetter })
                }}
              TextField("Cost", text: Binding<String>(
                         get: { String(describing: viewModel.purchase.pieces) },
                         set: { viewModel.purchase.pieces = Int($0) ?? 0 }
                     ))
          }
           

           
          if mode == .edit {
            Section {
              Button("Delete User") { self.presentActionSheet.toggle() }
                .foregroundColor(.red)
            }
          }
        }
        .navigationTitle(mode == .new ? "New Product" : viewModel.purchase.name)
        .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
        .navigationBarItems(
          leading: cancelButton,
          trailing: saveButton
        )
        .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete Product"),
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

struct PurchaseEditView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseEditView()
    }
}
