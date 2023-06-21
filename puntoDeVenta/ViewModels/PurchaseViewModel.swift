//
//  PurchaseViewModel.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 18/05/23.
//

import Foundation
import Combine
import Firebase
import FirebaseFirestore

 
class PurchaseViewModel: ObservableObject {
   
  @Published var purchase: Purchase
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(purchase: Purchase = Purchase(IdProduct: "",name: "", pieces: 0)) {
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
        let _ = try db.collection("purchase").addDocument(from: purchase) { error in
          if let error = error {
            print(error.localizedDescription)
          }
        }
      }
      catch {
        print(error)
      }
    }

    private func updatePurchase(_ purchase: Purchase) {
      if let documentId = purchase.id {
        do {
          try db.collection("purchase").document(documentId).setData(from: purchase) { error in
            if let error = error {
              print(error.localizedDescription)
            }
          }
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
    
    func updateProduct(units: Int, productId: String) {
        let db = Firestore.firestore()
        let productRef = db.collection("product").document(productId)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let documentSnapshot: DocumentSnapshot
            do {
                try documentSnapshot = transaction.getDocument(productRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            guard let productData = documentSnapshot.data() else {
                let error = NSError(domain: "AppErrorDomain", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Document does not exist."
                ])
                errorPointer?.pointee = error
                return nil
            }
            
            var currentUnits = productData["units"] as? Int ?? 0
            currentUnits += units
            
            transaction.updateData(["units": currentUnits], forDocument: productRef)
            
            return nil
        }) { (object, error) in
            if let error = error {
                print("Transaction failed: \(error.localizedDescription)")
            } else {
                print("Transaction successfully committed!")
            }
        }
    }

    func updateProduct2(decrementUnitsBy units: Int, productId: String) {
        let db = Firestore.firestore()
        let productRef = db.collection("product").document(productId)
        
        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let documentSnapshot: DocumentSnapshot
            do {
                try documentSnapshot = transaction.getDocument(productRef)
            } catch let fetchError as NSError {
                errorPointer?.pointee = fetchError
                return nil
            }
            
            guard var productData = documentSnapshot.data() else {
                let error = NSError(domain: "AppErrorDomain", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Document does not exist."
                ])
                errorPointer?.pointee = error
                return nil
            }
            
            var currentUnits = productData["units"] as? Int ?? 0
            currentUnits -= units
            
            productData["units"] = currentUnits
            transaction.setData(productData, forDocument: productRef)
            
            return nil
        }) { (object, error) in
            if let error = error {
                print("Transaction failed: \(error.localizedDescription)")
            } else {
                print("Transaction successfully committed!")
            }
        }
    }






   
    private func removePurchase() {
        if let documentId = purchase.id {
            db.collection("purchase").document(documentId).delete { [weak self] error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    // Subtract the units from the product
                    if let productId = self?.purchase.IdProduct, let pieces = self?.purchase.pieces {
                        let productsRef = self?.db.collection("product")
                        let productDocRef = productsRef?.document(productId)
                        
                        productDocRef?.updateData(["units": FieldValue.increment(-Int64(pieces))]) { error in
                            if let error = error {
                                print("Error subtracting units from the product: \(error)")
                            } else {
                                print("Units subtracted from the product successfully.")
                            }
                        }
                    }
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

