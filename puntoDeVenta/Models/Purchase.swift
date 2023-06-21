//
//  Purchase.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 18/05/23.
//

import Foundation
import FirebaseFirestoreSwift
 
struct Purchase: Identifiable, Codable {
  @DocumentID var id: String?
    var IdProduct: String
    var name: String
    var pieces: Int
    
   
  enum CodingKeys: String, CodingKey {
      case IdProduct
      case name
      case pieces
  }
}
