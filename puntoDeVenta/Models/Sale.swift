//
//  Sale.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 18/05/23.
//

import Foundation
import FirebaseFirestoreSwift
 
struct Sale: Identifiable, Codable {
    
  @DocumentID var id: String?
 var IdClient: String
    var IdProduct: String
  var name: String
  var subtotal: Double
  var total: Double
    var pieces: Int
    
   
  enum CodingKeys: String, CodingKey {
      case IdClient
      case IdProduct
      case name
      case subtotal
      case total
      case pieces
      
  }
}
