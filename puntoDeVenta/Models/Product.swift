//
//  Product.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 18/05/23.
//

import Foundation
import FirebaseFirestoreSwift
 
struct Product: Identifiable, Codable {
  @DocumentID var id: String?
  var name: String
  var description: String
  var cost: Double
  var price: Double
    var units: Int
    var utility : Double
   
  enum CodingKeys: String, CodingKey {
      case name
      case description
      case cost
      case price
      case units
      case utility
  }
}
