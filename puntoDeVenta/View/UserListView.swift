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
    @StateObject var viewModel = UsersViewModel()
    @State private var presentAddUserSheet = false
    
    private var addButton: some View {
        Button(action: { self.presentAddUserSheet.toggle() }) {
            Image(systemName: "plus")
        }
    }
    
    private func userRowView(user: User) -> some View {
        NavigationLink(destination: UserDetailView(user: user)) {
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text(user.email)
                    .font(.subheadline)
            }.cornerRadius(10.0)
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    userRowView(user: user)
                }
                .onDelete() { indexSet in
                    viewModel.removeUsers(atOffsets: indexSet)
                }
            }
            .navigationBarTitle("Users")
            .navigationBarItems(trailing: addButton)
            .onAppear() {
                print("UserListView appears. Subscribing to data updates.")
                self.viewModel.subscribe()
            }
            .sheet(isPresented: self.$presentAddUserSheet) {
                UserEditView()
            }
            .background(Color.primaryColor) // Fondo principal
            .foregroundColor(Color.secondaryColor) // Color de texto principal
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
extension Color {
    static let primaryColor = Color(#colorLiteral(red: 0.741, green: 0.478, blue: 0.133, alpha: 1.0))
    static let secondaryColor = Color(#colorLiteral(red: 0.906, green: 0.565, blue: 0.133, alpha: 1.0))
}


struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
