//
//  CartView.swift
//  MealKit
//
//  Purpose:
//  --------
//  Shopping cart screen. Lists cart lines with quantity steppers and remove,
//  shows subtotal, and routes to CheckoutView. Optionally offers “Empty Cart”.
//
//  Created by Jeffery Wang on 3/9/2025.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartStore

    var body: some View {
        VStack {
            if cart.lines.isEmpty {
                ContentUnavailableView("Your cart is empty",
                                       systemImage: "cart",
                                       description: Text("Add meals"))
                    .padding()
            } else {
                List {
                    ForEach(cart.lines) { line in
                        HStack(alignment: .top, spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8).fill(.ultraThinMaterial)
                                    .frame(width: 60, height: 60)
                                if let img = line.meal.imageName, UIImage(named: img) != nil {
                                    Image(img).resizable().scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    Image(systemName: "fork.knife.circle")
                                        .imageScale(.large)
                                        .foregroundStyle(.secondary)
                                }
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(line.meal.name)
                                    .font(.subheadline).bold()
                                    .lineLimit(2)
                                Text(line.meal.price, format: .currency(code: cart.currencyCode))
                                    .font(.caption).foregroundColor(.secondary)

                                // Quantity control
                                HStack {
                                    Stepper("Qty: \(line.quantity)") {
                                        cart.setQuantity(for: line.id, quantity: line.quantity + 1)
                                    } onDecrement: {
                                        cart.setQuantity(for: line.id, quantity: line.quantity - 1)
                                    }
                                    .labelsHidden()

                                    Spacer()
                                    Text(line.lineTotal, format: .currency(code: cart.currencyCode))
                                        .font(.subheadline).bold()
                                }
                            }
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                cart.remove(lineID: line.id)
                            } label: {
                                Label("Remove", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.insetGrouped)

                // Footer with totals + checkout
                VStack(spacing: 12) {
                    HStack {
                        Text("Subtotal")
                        Spacer()
                        Text(cart.subtotal, format: .currency(code: cart.currencyCode))
                            .bold()
                    }
                    .padding(.horizontal)

                    NavigationLink(destination: CheckoutView()) {
                        Text("Proceed to Purchase")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.accentColor))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                    Button(role: .destructive) {
                        cart.clear()
                    } label: {
                        Text("Empty Cart")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.red.opacity(0.8)))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .navigationTitle("Cart")
    }
}

#Preview {
    NavigationStack { CartView() }
        .environmentObject(CartStore())
}
