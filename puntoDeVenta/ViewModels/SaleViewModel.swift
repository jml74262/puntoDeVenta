//
//  SaleViewModel.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 18/05/23.
//

import Foundation
import Combine
import FirebaseFirestore

class SaleVieModel : ObservableObject {
   
  @Published var sale: Sale
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(sale: Sale = Sale(name: "", subtotal: 0.0, total: 0.0, pieces: 0)) {
    self.sale = sale
     
    self.$sale
      .dropFirst()
      .sink { [weak self] sale in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addSale(_ sale: Sale) {
    do {
      let _ = try db.collection("sale").addDocument(from: sale)
    }
    catch {
      print(error)
    }
  }
   
  private func updateSale(_ sale: Sale) {
      if let documentId = sale.id {
      do {
        try db.collection("sale").document(documentId).setData(from: sale)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddSale() {
      if let _ = sale.id {
      self.updateSale(self.sale)
    }
    else {
      addSale(sale)
    }
  }
   
  private func removeSale() {
    if let documentId = sale.id {
      db.collection("sale").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddSale()
  }
   
  func handleDeleteTapped() {
    self.removeSale()
  }
   
}


