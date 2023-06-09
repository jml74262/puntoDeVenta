//
//  PurchaseListView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 19/05/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine
import SwiftUI

struct PurchaseListView: View {
    @StateObject var viewModel = PurchasesViewModel() //MovieViewModel.swift
    @State var presentAddMovieSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddMovieSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
    private func purchaseRowView(purchase: Purchase) -> some View {
       NavigationLink(destination: PurchaseDetailView(purchase: purchase)) { //MovieDetailsView.swift
         VStack(alignment: .leading) {
           Text(purchase.name)
             .font(.headline)
           //Text(movie.description)
           //  .font(.subheadline)
             Text(String(purchase.pieces))
             .font(.subheadline)
         }
       }
    }
    var body: some View {
        ZStack{
            List {
                ForEach (viewModel.purchases) { purchase in
                purchaseRowView(purchase: purchase)
              }
              .onDelete() { indexSet in
                //viewModel.removeMovies(atOffsets: indexSet)
                  viewModel.removePurchases(atOffsets: indexSet)
              }
            }
            
        }
      
        .cornerRadius(40)
        .background(Color.clear)
        .navigationBarTitle("Purchase")
        .navigationBarTitleDisplayMode(.inline)
        .foregroundColor(Color(hex: 0x964B00))
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("PurchaseListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddMovieSheet) {
          PurchaseEditView() //MovieEditView.swift
        }
        .foregroundColor(Color(hex: 0x964B00))
        .background(Image("rosa"))
    
    }// End Body
}

struct PurchaseListView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseListView()
    }
}
