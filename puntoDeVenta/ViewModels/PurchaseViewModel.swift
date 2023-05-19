//
//  PurchaseViewModel.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 18/05/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class PurchaseViewModel: ObservableObject {
   
  @Published var purchase: Purchase
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(purchase: Purchase = Purchase(name: "", pieces: 0)) {
    self.purchase = purchase
     
    self.$purchase
      .dropFirst()
      .sink { [weak self] purchase in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addPurchase(_ purchase: Purchase) {
    do {
      let _ = try db.collection("purchase").addDocument(from: purchase)
    }
    catch {
      print(error)
    }
  }
   
  private func updatePurchase(_ purchase: Purchase) {
      if let documentId = purchase.id {
      do {
        try db.collection("purchase").document(documentId).setData(from: purchase)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddPurchase() {
      if let _ = purchase.id {
      self.updatePurchase(self.purchase)
    }
    else {
      addPurchase(purchase)
    }
  }
   
  private func removePurchase() {
    if let documentId = purchase.id {
      db.collection("purchase").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddPurchase()
  }
   
  func handleDeleteTapped() {
    self.removePurchase()
  }
   
}

