//
//  ProductEditView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 19/05/23.
//

import SwiftUI


struct ProductEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = ProductViewModel()
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
          Section(header: Text("Product")) {
              TextField("Name", text: $viewModel.product.name).onChange(of: viewModel.product.name) { value in
                  if !value.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
                    viewModel.product.name = String(value.filter { $0.isLetter })
                }}
            TextField("Description", text: $viewModel.product.description)
              TextField("Cost", text: Binding<String>(
                         get: { String(describing: viewModel.product.cost) },
                         set: { viewModel.product.cost = Double($0) ?? 0 }
                     ))
              TextField("Price", text: Binding<String>(
                         get: { String(describing: viewModel.product.price) },
                         set: { viewModel.product.price = Double($0) ?? 0 }
                     ))
              TextField("Cost", text: Binding<String>(
                         get: { String(describing: viewModel.product.units) },
                         set: { viewModel.product.units = Int($0) ?? 0 }
                     ))
              TextField("Utility", text: Binding<String>(
                         get: { String(describing: viewModel.product.utility) },
                         set: { viewModel.product.utility = Double($0) ?? 0 }
                     ))
          }
           

           
          if mode == .edit {
            Section {
              Button("Delete User") { self.presentActionSheet.toggle() }
                .foregroundColor(.red)
            }
          }
        }
        .cornerRadius(40)
        .background(Image("rosa"))
        .navigationTitle(mode == .new ? "New Product" : viewModel.product.name)
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
        .foregroundColor(Color(hex: 0xC3ADE6))
        .navigationBarTitleDisplayMode(.inline)
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
struct ProductEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProductEditView()
    }
}
