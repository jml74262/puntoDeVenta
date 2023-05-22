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
        
        ZStack{
            
         
               
                 
                 List {
                     ForEach(viewModel.users) { user in
                         userRowView(user: user)
                     }
                     .onDelete() { indexSet in
                         viewModel.removeUsers(atOffsets: indexSet)
                     }
                 }
                 
                 
           

          
        }
   
        .cornerRadius(40)
        .background(Color.clear)
        .navigationBarTitle("Users")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundColor(Color(hex: 0xC3ADE6))
            .navigationBarItems(trailing: addButton)
            .onAppear() {
                print("UserListView appears. Subscribing to data updates.")
                self.viewModel.subscribe()
            }
            .sheet(isPresented: self.$presentAddUserSheet) {
                UserEditView()
            }
        
         // Fondo principal
            .foregroundColor(Color(hex: 0xC3ADE6))
            .background(Image("rosa"))// Color de texto principal
            
        
        
    }
    
}



struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}
