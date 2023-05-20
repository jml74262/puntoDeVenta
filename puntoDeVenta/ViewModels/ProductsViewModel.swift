//
//  ProductsViewModel.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 18/05/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class ProductsViewModel: ObservableObject {
  @Published var products = [Product]()
   
  private var db = Firestore.firestore()
  private var listenerRegistration: ListenerRegistration?
   
  deinit {
    unsubscribe()
  }
   
  func unsubscribe() {
    if listenerRegistration != nil {
      listenerRegistration?.remove()
      listenerRegistration = nil
    }
  }
   
    func subscribe() {
      if listenerRegistration == nil {
        listenerRegistration = db.collection("product").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }
           
          self.products = documents.compactMap { queryDocumentSnapshot in
              var product = try? queryDocumentSnapshot.data(as: Product.self)
              product?.id = queryDocumentSnapshot.documentID;
              return product
          }
        }
      }
    }
   
  func removeProducts(atOffsets indexSet: IndexSet) {
    let products = indexSet.lazy.map { self.products[$0] }
    products.forEach { product in
      if let documentId = product.id {
        db.collection("product").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
 
   
}
