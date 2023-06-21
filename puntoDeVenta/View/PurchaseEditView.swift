//
//  PurchaseEditView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 19/05/23.
//

import SwiftUI
import FirebaseFirestore

struct PurchaseEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @StateObject private var productViewModel = ProductsViewModel()
    @State private var selectedProduct: Product?
    @State private var isDropdownExpanded = false
    @ObservedObject var viewModel = PurchaseViewModel()
    @State private var selectedProductUnits: Int = 0
    @State private var piecesText: String = ""
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?

    var cancelButton: some View {
        Button(action: { self.handleCancelTapped() }) {
            Text("Cancel")
        }
    }

    var saveButton: some View {
        Button(action: {  self.handleDoneTapped() }) {
            Text(mode == .new ? "Done" : "Save")
        }
        .disabled(!isEditable || (mode == .edit && !viewModel.modified))
    }

    var isEditable: Bool {
        return mode != .edit
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Purchase")) {
                    VStack {
                        DropdownOptionElement(
                            title: "Select Product",
                            isSelected: $isDropdownExpanded
                        ) {
                            ForEach(productViewModel.products, id: \.id) { product in
                                VStack {
                                    Button(action: {
                                    }) {
                                        Text(product.name)
                                            .foregroundColor(.black)
                                            .frame(width: UIScreen.main.bounds.size.width * 0.80)
                                    }
                                    .background(.white)
                                    .disabled(!isEditable || mode == .edit) // Disable user interaction
                                }
                                .padding()
                                .scaledToFill()
                                .onTapGesture(perform: {
                                    print(product)
                                    self.selectedProduct = product
                                    self.isDropdownExpanded = false
                                    viewModel.purchase.name = selectedProduct?.name ?? ""
                                    viewModel.purchase.IdProduct = selectedProduct?.id ?? ""
                                })
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
                    TextField("Pieces", text: $piecesText)
                               .keyboardType(.numberPad)
                               .disabled(!isEditable || mode == .edit) // Disable editing when mode is .edit
                               .onChange(of: piecesText) { newValue in
                                   let filtered = newValue.filter { "0123456789".contains($0) }
                                   piecesText = filtered
                                   viewModel.purchase.pieces = Int(filtered) ?? 0
                               }
                    .keyboardType(.numberPad)
                    .disabled(!isEditable || mode == .edit) // Disable editing when mode is .edit
                }

                if mode == .edit {
                    Section {
                        Button("Delete Purchase") { self.presentActionSheet.toggle() }
                            .foregroundColor(.red)
                    }
                }
            } 
            .cornerRadius(40)
            .background(Image("rosa"))
            .navigationTitle(mode == .new ? "New Purchase" : viewModel.purchase.name)
            .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
            .navigationBarItems(
                leading: cancelButton,
                trailing: saveButton
            )
            .actionSheet(isPresented: $presentActionSheet) {
                ActionSheet(title: Text("Are you sure?"),
                            buttons: [
                                .destructive(Text("Delete Purchase"),
                                             action: { self.handleDeleteTapped() }),
                                .cancel()
                            ])
            }
        }
        .foregroundColor(Color(hex: 0x964B00))
        .navigationBarTitleDisplayMode(.inline)
    }

    // Action Handlers

    func handleCancelTapped() {
        self.dismiss()
    }

    // ...

    func handleDoneTapped() {
        guard var selectedProduct = selectedProduct else {
            // Handle case when no product is selected
            return
        }

        // Update the selected product with the entered units
        selectedProduct.units = viewModel.purchase.pieces

        // Update the product in Firebase
        viewModel.updateProduct(units: selectedProduct.units, productId: selectedProduct.id ?? "")

        // Dismiss the view
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
