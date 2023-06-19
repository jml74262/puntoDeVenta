//
//  DropdownOptionElement.swift
//  puntoDeVenta
//
//  Created by Martha Almanza Izquierdo Almanza on 15/06/23.
//



import SwiftUI

struct DropdownOptionElement<Content: View>: View {
    let title: String
    let isSelected: Binding<Bool>
    let content: () -> Content
    
    var body: some View {
        DisclosureGroup(isExpanded: isSelected) {
            content()
        } label: {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: isSelected.wrappedValue ? "chevron.up" : "chevron.down")
                    .foregroundColor(.black)
            }
        }
        .accentColor(.black)
    }
}
