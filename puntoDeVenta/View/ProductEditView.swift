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
    @State private var costText: String = ""
    @State private var priceText: String = ""
    @State private var unitsText: String = ""
    @State private var utilityText: String = ""
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
                        }
                    }
                    TextField("Description", text: $viewModel.product.description).onChange(of: viewModel.product.description) { value in
                        if !value.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
                            viewModel.product.description = String(value.filter { $0.isLetter })
                        }
                    }
                    TextField("Cost", text: $costText )
                        .onAppear {
                            costText = String(viewModel.product.cost)
                        }
                        .onChange(of: costText) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0)}
                            costText = filtered
                            viewModel.product.cost = Double(filtered) ?? 0.0
                        }
                    
                    TextField("Price", text: $priceText)
                        .onAppear {
                            priceText = String(viewModel.product.price)
                        }
                        .onChange(of: priceText) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            priceText = filtered
                            viewModel.product.price = Double(filtered) ?? 0.0
                        }
                        .keyboardType(.numberPad)
                    
                    if mode == .edit {
                        TextField("Units", text: $unitsText)
                            .disabled(true) // Desactiva la edición del campo cuando el modo sea "edit"
                            .onAppear {
                                unitsText = String(viewModel.product.units)
                            }
                            .keyboardType(.numberPad)
                    } else {
                        TextField("Units", text: $unitsText)
                            .onChange(of: unitsText) { newValue in
                                let filtered = newValue.filter { "0123456789.".contains($0) }
                                unitsText = filtered
                                viewModel.product.units = Int(filtered) ?? 0
                            }
                            .keyboardType(.numberPad)
                    }
                    
                    TextField("Utility", text: $utilityText)
                        .onAppear {
                            utilityText = String(viewModel.product.utility)
                        }
                        .onChange(of: utilityText) { newValue in
                            let filtered = newValue.filter { "0123456789.".contains($0) }
                            utilityText = filtered
                            viewModel.product.utility = Double(filtered) ?? 0.0
                        }
                        .keyboardType(.numberPad)
                }
                
                if mode == .edit {
                    Section {
                        Button("Delete Product") { self.presentActionSheet.toggle() }
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
        .foregroundColor(Color(hex: 0x964B00))
        .navigationBarTitleDisplayMode(.inline)
    }
    
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
