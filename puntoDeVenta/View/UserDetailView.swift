//
//  UserDetailView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 19/05/23.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditMovieSheet = false
     
    var user: User
     
    private func editButton(action: @escaping () -> Void) -> some View {
      Button(action: { action() }) {
        Text("Edit")
      }
    }
       
    var body: some View {
      
      Form {
        Section(header: Text("User")) {
            Text(user.name).bold()
            Text(user.lastname).bold()
            Text(user.email).bold()
            Text(String(user.age)).bold()
            Text(user.gender).bold()
            Text(user.password).bold()
            
            
        }
      }
      .cornerRadius(40)
      .background(Color.clear) // Establece el fondo del Form como transparente
      .padding()
      .navigationBarTitle(user.name)
      .navigationBarItems(trailing: editButton {
        self.presentEditMovieSheet.toggle()
      })
      .onAppear() {
        print("UserDetailView.onAppear() for \(self.user.name)")
      }
      .onDisappear() {
        print("UserDetailView.onDisappear()")
      }
      .sheet(isPresented: self.$presentEditMovieSheet) {
        UserEditView(viewModel: UserViewModel(user: user), mode: .edit) { result in
          if case .success(let action) = result, action == .delete {
            self.presentationMode.wrappedValue.dismiss()
          }
        }
      }
      
      .foregroundColor(Color(hex: 0xC3ADE6))
      .background(Image("rosa"))
      
            
    }
     
        
     
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let user = User(age: 21, email: "example@example.com", gender: "Gender", lastname: "Lastname", name: "name", password: "Pass")
        return
          NavigationView {
            UserDetailView(user: user)
          }
    }
}
