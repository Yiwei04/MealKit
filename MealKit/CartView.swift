//
//  CartView.swift
//  MealKit
//
//  Purpose:
//  --------
//  Shopping cart screen. Lists cart lines with quantity steppers and remove,
//  shows subtotal, and routes to CheckoutView. Presents alerts for invalid
//  quantity operations. Optional “Empty Cart” hook.
//
//  Created by Jeffery Wang on 3/9/2025.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartStore
    @State private var cartError: AppError?   // <- for quantity/limit errors

    var body: some View {
        VStack {
            if cart.lines.isEmpty {
                ContentUnavailableView("Your cart is empty",
                                       systemImage: "cart",
                                       description: Text("Add meals from Keto or High Protein."))
                    .padding()
            } else {
                List {
                    ForEach(cart.lines) { line in
                        HStack(alignment: .top, spacing: 12) {
                            // Thumbnail (optional image)
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

                                // Quantity control with validation
                                HStack {
                                    Stepper("Qty: \(line.quantity)") {
                                        do {
                                            try cart.setQuantity(for: line.id, quantity: line.quantity + 1)
                                        } catch let err as AppError {
                                            cartError = err
                                        } catch {
                                            cartError = .invalidQuantity
                                        }
                                    } onDecrement: {
                                        do {
                                            try cart.setQuantity(for: line.id, quantity: line.quantity - 1)
                                        } catch let err as AppError {
                                            cartError = err
                                        } catch {
                                            cartError = .invalidQuantity
                                        }
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

                // Footer with totals + checkout (and optional empty-cart)
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

                    // OPTIONAL: one-tap empty cart (comment out if not desired)
                    Button(role: .destructive) {
                        cart.clear()
                    } label: {
                        Text("Empty Cart")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color.red.opacity(0.85)))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .navigationTitle("Cart")

        // Error alert for cart operations
        .alert("Cart issue",
               isPresented: .constant(cartError != nil),
               presenting: cartError) { _ in
            Button("OK", role: .cancel) { cartError = nil }
        } message: { err in
            Text(err.localizedDescription)
        }
    }
}

#Preview {
    NavigationStack { CartView() }
        .environmentObject(CartStore())
}
