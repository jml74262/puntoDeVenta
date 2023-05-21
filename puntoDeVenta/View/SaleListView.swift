//
//  SaleListView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 21/05/23.
//
import Foundation
import Firebase
import FirebaseFirestore
import Combine
import SwiftUI

struct SaleListView: View {
    @StateObject var viewModel = SalesViewModel() //MovieViewModel.swift
    @State var presentAddMovieSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddMovieSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
    private func saleRowView(sale: Sale) -> some View {
       NavigationLink(destination: SaleDetailView(sale: sale)) { //MovieDetailsView.swift
         VStack(alignment: .leading) {
           Text(sale.name)
             .font(.headline)
           //Text(movie.description)
           //  .font(.subheadline)
            Text(String( sale.pieces))
             .font(.subheadline)
             Text(String( sale.total))
              .font(.subheadline)
         }
       }
    }
    
    var body: some View {
      NavigationView {
        List {
          ForEach (viewModel.sales) { sale in
            saleRowView(sale: sale)
          }
          .onDelete() { indexSet in
            //viewModel.removeMovies(atOffsets: indexSet)
            viewModel.removeSales(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("Sale")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("SaleListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddMovieSheet) {
          SaleEditView() //MovieEditView.swift
        }
         
      }// End Navigation
    }// End Body
}
struct SaleListView_Previews: PreviewProvider {
    static var previews: some View {
        SaleListView()
    }
}
