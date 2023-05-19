//
//  UserViewModel.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 18/05/23.
//

import Foundation
import Combine
import FirebaseFirestore


class UserViewModel : ObservableObject {
   
  @Published var user: User
  @Published var modified = false
   
  private var cancellables = Set<AnyCancellable>()
   
    init(user: User = User(age: 0, email: "", gender: "", lastname: "", name: "", password: "")) {
    self.user = user
     
    self.$user
      .dropFirst()
      .sink { [weak self] user in
        self?.modified = true
      }
      .store(in: &self.cancellables)
  }
   
  // Firestore
   
  private var db = Firestore.firestore()
   
  private func addUser(_ user: User) {
    do {
      let _ = try db.collection("user").addDocument(from: user)
    }
    catch {
      print(error)
    }
  }
   
  private func updateUser(_ user: User) {
      if let documentId = user.id {
      do {
        try db.collection("user").document(documentId).setData(from: user)
      }
      catch {
        print(error)
      }
    }
  }
   
  private func updateOrAddUser() {
      if let _ = user.id {
      self.updateUser(self.user)
    }
    else {
      addUser(user)
    }
  }
   
  private func removeUser() {
    if let documentId = user.id {
      db.collection("user").document(documentId).delete { error in
        if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
   
  // UI handlers
   
  func handleDoneTapped() {
    self.updateOrAddUser()
  }
   
  func handleDeleteTapped() {
    self.removeUser()
  }
   
}

