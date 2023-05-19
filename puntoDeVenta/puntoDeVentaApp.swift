//
//  puntoDeVentaApp.swift
//  puntoDeVenta
//
//  Created by ISSC_611_2023 on 24/04/23.
//

import SwiftUI
import Firebase

@main
struct puntoDeVentaApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
    
        WindowGroup {
            ContentView()
            
        }
    }
    
}

