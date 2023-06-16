//
//  SaleEditView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 21/05/23.
//
import SwiftUI

struct SaleEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @StateObject private var productViewModel = ProductsViewModel()
    @State private var selectedProduct: Product?
    @State private var isDropdownExpanded = false
    
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

    struct Product: Identifiable, Hashable {
        let id: String
        let name: String
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sale")) {
                    VStack {
                        DropdownOptionElement(
                            title: "Select Product",
                            isSelected: $isDropdownExpanded
                        ) {
                            ForEach(productViewModel.products, id: \.id) { product in
                                Button(action: {
                                  //  product.isSelected.toggle()
                                    self.isDropdownExpanded = false
                                }) {
                                    Text(product.name)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .foregroundColor(.black)

                        if let selectedProduct = selectedProduct {
                            Text("Selected Product: \(selectedProduct.name)")
                                .padding()
                        }
                    }
                    .onAppear {
                        productViewModel.fetchProducts()
                    }
                }
            }
            .navigationBarTitle(mode == .new ? "New Sale" : viewModel.sale.name)
            .navigationBarItems(
                leading: cancelButton,
                trailing: saveButton
            )
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
