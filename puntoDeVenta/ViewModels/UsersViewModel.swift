//
//  UsersViewModel.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 18/05/23.
//

import Foundation
import Combine
import FirebaseFirestore
 
class UsersViewModel: ObservableObject {
  @Published var users = [User]()
   
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
      listenerRegistration = db.collection("user").addSnapshotListener { (querySnapshot, error) in
        guard let documents = querySnapshot?.documents else {
          print("No documents")
          return
        }
         
        self.users = documents.compactMap { queryDocumentSnapshot in
            var user = try? queryDocumentSnapshot.data(as: User.self)
            user?.id = queryDocumentSnapshot.documentID;
            return user
        }
      }
    }
  }
   
  func removeUsers(atOffsets indexSet: IndexSet) {
    let users = indexSet.lazy.map { self.users[$0] }
    users.forEach { user in
      if let documentId = user.id {
        db.collection("user").document(documentId).delete { error in
          if let error = error {
            print("Unable to remove document: \(error.localizedDescription)")
          }
        }
      }
    }
  }
}

