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
    @StateObject var viewModel = UsersViewModel() //MovieViewModel.swift
    @State var presentAddMovieSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddMovieSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
    private func userRowView(user: User) -> some View {
       NavigationLink(destination: UserDetailView(user: user)) { //MovieDetailsView.swift
         VStack(alignment: .leading) {
           Text(user.name)
             .font(.headline)
           //Text(movie.description)
           //  .font(.subheadline)
            Text(user.email)
             .font(.subheadline)
         }
       }
    }
    
    /*List {
                ForEach(viewModel.user) { user in
                            Text(user.name + " " + user.lastname)
                            Text(user.email)
                            Text(String(user.age))
                            // Agrega más vistas para mostrar otras propiedades del usuario
                        }
            }*/
    var body: some View {
      NavigationView {
        List {
          ForEach (viewModel.users) { user in
            userRowView(user: user)
          }
          .onDelete() { indexSet in
            //viewModel.removeMovies(atOffsets: indexSet)
            viewModel.removeUsers(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("User")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("UserListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddMovieSheet) {
          UserEditView() //MovieEditView.swift
        }
         
      }// End Navigation
    }// End Body
}
struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
