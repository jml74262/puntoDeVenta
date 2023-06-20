import SwiftUI
import Firebase

struct SaleEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @StateObject private var productViewModel = ProductsViewModel()
    @State private var selectedProduct: Product?
    @StateObject private var userViewModel = UsersViewModel()
    @State private var selectedUser: User?
    @State private var isDropdownExpanded = false
    @State private var isDropdownExpanded2 = false
    @State private var selectedAmount = 0;
    
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
    
    struct product: Identifiable, Hashable {
        let id: String
        let name: String
    }
    
    var isEditable: Bool {
        return mode == .new
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sale")) {
                    VStack {
                        DropdownOptionElement(
                            title: "Select Client",
                            isSelected: $isDropdownExpanded2
                        ) {
                            ForEach(userViewModel.users, id: \.id) { user in
                                VStack{
                                    Button(action: {
                                    }) {
                                        Text(user.name)
                                            .foregroundColor(.black)
                                            .frame(width: UIScreen.main.bounds.size.width * 0.80)
                                    }
                                    .background(.white)
                                    .disabled(!isEditable) // Disable user interaction
                                }
                                .padding()
                                .scaledToFill()
                                .onTapGesture(perform: {
                                    print(user)
                                    self.selectedUser = user
                                    self.isDropdownExpanded2 = false
                                })
                            }
                        }
                        .foregroundColor(.black)
                        
                        if let selectedUser = selectedUser {
                            Text("Selected User: \(selectedUser.name)")
                                .padding()
                        }
                    }
                    .onAppear {
                        userViewModel.fetchUsers()
                    }
                    
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
                                    .disabled(!isEditable) // Disable user interaction
                                }
                                .padding()
                                .scaledToFill()
                                .onTapGesture(perform: {
                                    print(product)
                                    self.selectedProduct = product
                                    self.isDropdownExpanded = false
                                    viewModel.sale.IdClient = selectedUser?.id ?? ""
                                    viewModel.sale.IdProduct = selectedProduct?.id ?? ""
                                    viewModel.sale.name = selectedProduct?.name ?? ""
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
                    
                    VStack {
                        Picker("How many?", selection: $selectedAmount) {
                            ForEach(0...(selectedProduct?.units ?? 0), id: \.self) { number in
                                Text("\(number)")
                            }
                        }
                        .disabled(!isEditable) // Disable user interaction
                    }
                    
                    VStack {
                        let price = selectedProduct?.price ?? 0
                        let formattedPrice = String(format: "%.2f", price)
                        Text("Precio unitario: \(formattedPrice)").bold()
                    }
                    
                    VStack {
                        Text("Cantidad a pagar: " + String((selectedProduct?.price ?? 0) * Double(selectedAmount))).bold()
                    }
                }
                
                if mode == .edit {
                    Section {
                        Button("Delete Sale") { self.presentActionSheet.toggle() }
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle(mode == .new ? "New Sale" : viewModel.sale.name)
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
        viewModel.sale.pieces = selectedAmount
        viewModel.sale.subtotal = selectedProduct?.price ?? 0
        viewModel.sale.total = (selectedProduct?.price ?? 0) * Double(selectedAmount)
        
        // Update the product units in Firebase
        if let selectedProduct = selectedProduct {
            let db = Firestore.firestore()
            let productsRef = db.collection("product")
            let productDocRef = productsRef.document(selectedProduct.id ?? "")
            
            productDocRef.updateData(["units": selectedProduct.units - selectedAmount]) { error in
                if let error = error {
                    print("Error updating product units: \(error)")
                } else {
                    print("Product units updated successfully.")
                    // Handle any additional actions or dismiss the view
                    self.viewModel.handleDoneTapped()
                    self.dismiss()
                }
            }
        } else {
            // Handle the case where no product is selected
            print("No hay producto seleccionado ")
        }
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
