//
//  UserListView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 19/05/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine
import SwiftUI

struct UserListView: View {
    @State private var users: [User] = []
    var body: some View {
        
        List {
            ForEach(users){ user in
                VStack(alignment: .leading) {
                    Text(user.name + " " + user.lastname)
                    Text(user.email)
                    Text(String(user.age))
                    // Agrega más vistas para mostrar otras propiedades del usuario
                }
            }
        }.onAppear{
            fetchUsers()
        }

    }
    
    func fetchUsers() {
            // Aquí es donde obtienes los datos de Firebase y los asignas a la variable "users"
            // Puedes usar Firestore, Realtime Database u otra herramienta de Firebase

            // Ejemplo de obtención de usuarios desde Firestore
            let db = Firestore.firestore()

            db.collection("user").getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error fetching users: \(error.localizedDescription)")
                    return
                }

                guard let documents = snapshot?.documents else {
                    print("No users found")
                    return
                }

                let _users:[User] = documents.compactMap { snapshot in
                    let data = snapshot.data()

                    if let name = data["name"] as? String,
                       let age = data["age"] as? Int,
                       let lastname = data["lastname"] as? String,
                       let password = data["password"] as? String,
                        let gender = data["gender"] as? String,
                       let email = data["email"] as? String {
                        return User(id: snapshot.documentID, age: age, email: email, gender: gender, lastname: lastname, name: name, password: password )
                    } else {
                        return nil
                    }
                }
                self.users = _users;
            }
        }
    }


struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}

