//
//  User.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 18/05/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var age: Int
    var email: String
    var gender: String
    var lastname: String
    var name: String
    var password: String
    var role: String
    
    
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case age
        case email
        case gender
        case lastname
        case name
        case password
        case role
    }
}
