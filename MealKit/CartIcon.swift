//
//  CartIcon.swift
//  MealKit
//
//  Purpose:
//  --------
//  Toolbar/cart button that displays a badge with the total item count from
//  CartStore. Tapping it navigates to CartView.
//
//  Created by Jeffery Wang on 3/9/2025.
//

import SwiftUI

struct CartIcon: View {
    @EnvironmentObject var cart: CartStore

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .imageScale(.large)
                .padding(.trailing, cart.itemCount > 0 ? 6 : 0)

            if cart.itemCount > 0 {
                Text("\(cart.itemCount)")
                    .font(.caption2).bold()
                    .padding(5)
                    .background(Circle().fill(Color.red))
                    .foregroundColor(.white)
                    .offset(x: 8, y: -8)
                    .accessibilityLabel(Text("\(cart.itemCount) items in cart"))
            }
        }
    }
}
