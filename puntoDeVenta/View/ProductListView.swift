//
//  ProductListView.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 19/05/23.
//
import Foundation
import Firebase
import FirebaseFirestore
import Combine
import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel = ProductsViewModel() //MovieViewModel.swift
    @State var presentAddMovieSheet = false
     
     
    private var addButton: some View {
      Button(action: { self.presentAddMovieSheet.toggle() }) {
        Image(systemName: "plus")
      }
    }
    private func productRowView(product: Product) -> some View {
       NavigationLink(destination: ProductDetailView(product: product)) { //MovieDetailsView.swift
         VStack(alignment: .leading) {
           Text(product.name)
             .font(.headline)
           //Text(movie.description)
           //  .font(.subheadline)
             Text(String(product.price))
             .font(.subheadline)
         }
       }
    }
    var body: some View {
      NavigationView {
        List {
            ForEach (viewModel.products) { product in
            productRowView(product: product)
          }
          .onDelete() { indexSet in
            //viewModel.removeMovies(atOffsets: indexSet)
            viewModel.removeProducts(atOffsets: indexSet)
          }
        }
        .navigationBarTitle("Product")
        .navigationBarItems(trailing: addButton)
        .onAppear() {
          print("ProductListView appears. Subscribing to data updates.")
          self.viewModel.subscribe()
        }
        .sheet(isPresented: self.$presentAddMovieSheet) {
          ProductEditView() //MovieEditView.swift
        }
         
      }// End Navigation
    }// End Body
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
