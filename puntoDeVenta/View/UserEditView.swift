//
//  UserEditView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 19/05/23.
//

import SwiftUI

enum Mode {
  case new
  case edit
}
 
enum Action {
  case delete
  case done
  case cancel
}

struct UserEditView: View {
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
     
    @ObservedObject var viewModel = UserViewModel()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
     
     
    var cancelButton: some View {
      Button(action: { self.handleCancelTapped() }) {
        Text("Cancel")
      }
    }
     
    var saveButton: some View {
      Button(action: { self.handleDoneTapped() }) {
        Text(mode == .new ? "Done" : "Save")
      }
      .disabled(!viewModel.modified)
    }
     
    var body: some View {
      NavigationView {
        Form {
          Section(header: Text("User")) {
              TextField("Name", text: $viewModel.user.name).onChange(of: viewModel.user.name) { value in
                  if !value.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
                    viewModel.user.name = String(value.filter { $0.isLetter })
                }}
            TextField("Lastname", text: $viewModel.user.lastname).onChange(of: viewModel.user.lastname) { value in
                if !value.allSatisfy({ $0.isLetter || $0.isWhitespace }) {
                  viewModel.user.lastname = String(value.filter { $0.isLetter })
              }}
              TextField("Age", text: Binding<String>(
                  get: { String(describing: viewModel.user.age) },
                  set: { newValue in
                      let filtered = newValue.filter { $0.isNumber }
                      viewModel.user.age = Int(filtered) ?? 0
                  }
              ))
              .keyboardType(.numberPad)


              TextField("Mail", text: $viewModel.user.email).onChange(of: viewModel.user.email) { value in
                  if !value.allSatisfy({ $0.isLetter}) {
                    viewModel.user.email = String(value.filter { $0.isLetter })
                }}
              TextField("Gender", text: $viewModel.user.gender).onChange(of: viewModel.user.gender) { value in
                  if !value.allSatisfy({ $0.isLetter}) {
                    viewModel.user.gender = String(value.filter { $0.isLetter })
                }}
              TextField("Password", text: $viewModel.user.password)
          }
           

           
          if mode == .edit {
            Section {
              Button("Delete User") { self.presentActionSheet.toggle() }
                .foregroundColor(.red)
            }
          }
        }
        .cornerRadius(40)
        .background(Image("rosa"))
        .navigationTitle(mode == .new ? "New User" : viewModel.user.name)
        .navigationBarTitleDisplayMode(mode == .new ? .inline : .large)
        .navigationBarItems(
          leading: cancelButton,
          trailing: saveButton
        )
        .actionSheet(isPresented: $presentActionSheet) {
          ActionSheet(title: Text("Are you sure?"),
                      buttons: [
                        .destructive(Text("Delete User"),
                                     action: { self.handleDeleteTapped() }),
                        .cancel()
                      ])
        }
      }.edgesIgnoringSafeArea(.all)
      .foregroundColor(Color(hex: 0xC3ADE6))
      .navigationBarTitleDisplayMode(.inline)
      
    }
     
    // Action Handlers
     
    func handleCancelTapped() {
      self.dismiss()
    }
     
    func handleDoneTapped() {
      self.viewModel.handleDoneTapped()
      self.dismiss()
    }
     
    func handleDeleteTapped() {
      viewModel.handleDeleteTapped()
      self.dismiss()
      self.completionHandler?(.success(.delete))
    }
     
    func dismiss() {
      self.presentationMode.wrappedValue.dismiss()
    }
  }
 
//struct MovieEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieEditView()
//    }
//}


struct UserEditView_Previews: PreviewProvider {
    static var previews: some View {
        UserEditView()
    }
}
