//
//  SaleEditView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 21/05/23.
//

import SwiftUI
import UIKit
import SwiftUI

struct SaleEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @StateObject private var productViewModel = ProductsViewModel()
    @State private var selectedProduct: Product?
     
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
                    VStack {
                        Picker("Select Product", selection: $selectedProduct) {
                            ForEach(productViewModel.products, id: \.id) { product in
                                Text(product.name)
                            }
                        }
                        .pickerStyle(MenuPickerStyle()).foregroundColor(.black)
                        
                        if let selectedProduct = selectedProduct {
                            Text("Selected Product: \(selectedProduct.name)")
                                .padding()
                        }
                    }
                }
                
                if mode == .edit {
                    Section {
                        Button("Delete Sale") { self.presentActionSheet.toggle() }
                            .foregroundColor(.red)
                    }
                }
            }
            .cornerRadius(40)
            .background(Image("rosa"))
            .navigationTitle(mode == .new ? "New Sale" : viewModel.sale.name)
            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
            .navigationBarItems(
                leading: cancelButton,
                trailing: saveButton
            )
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(title: Text("Are you sure?"),
                            buttons: [
                                .destructive(Text("Delete Sale"), action: { self.handleDeleteTapped() }),
                                .cancel()
                            ])
            }
        }
        .foregroundColor(Color(hex: 0xC3ADE6))
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
                  // Cargar los usuarios desde el userViewModel
            self.productViewModel.subscribe()
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
