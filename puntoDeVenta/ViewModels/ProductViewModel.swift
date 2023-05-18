//
//  PanViewModel.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 17/05/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class ProductViewModel: ObservableObject {
   
  @Published var product: Product
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(product: Product = Product(name: "", description: "", cost: 0.0, price: 0.0, units: 0, utility: 0.0)) {
    self.product = product
     
    self.$product
      .dropFirst()
      .sink { [weak self] product in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addProduct(_ product: Product) {
    do {
      let _ = try db.collection("product").addDocument(from: product)
    }
    catch {
      print(error)
    }
  }
   
  private func updateProduct(_ product: Product) {
      if let documentId = product.id {
      do {
        try db.collection("product").document(documentId).setData(from: product)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddPan() {
      if let _ = product.id {
      self.updateProduct(self.product)
    }
    else {
      addProduct(product)
    }
  }
   
  private func removeProduct() {
    if let documentId = product.id {
      db.collection("product").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddPan()
  }
   
  func handleDeleteTapped() {
    self.removeProduct()
  }
   
}
