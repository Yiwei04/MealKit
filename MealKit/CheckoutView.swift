//
//  CheckoutView.swift
//  MealKit
//
//  Purpose:
//  --------
//  Purchase/checkout form (contact + delivery). Simulates payment, then clears
//  the cart and shows confirmation before dismissing back to the flow.
//
//  Created by Jeffery Wang on 3/9/2025.
//

import SwiftUI

struct CheckoutView: View {
    @EnvironmentObject var cart: CartStore
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var email: String = ""
    @State private var address: String = ""
    @State private var placingOrder = false
    @State private var showConfirmation = false

    var body: some View {
        Form {
            Section("Order Summary") {
                HStack {
                    Text("Items")
                    Spacer()
                    Text("\(cart.itemCount)")
                }
                HStack {
                    Text("Subtotal")
                    Spacer()
                    Text(cart.subtotal, format: .currency(code: cart.currencyCode))
                }
            }

            Section("Contact") {
                TextField("Full name", text: $name)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }

            Section("Delivery") {
                TextField("Address", text: $address, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
            }

            Section {
                Button {
                    placeOrder()
                } label: {
                    if placingOrder {
                        ProgressView().frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        Text("Pay & Place Order")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .disabled(cart.lines.isEmpty || name.isEmpty || email.isEmpty || address.isEmpty || placingOrder)
            } footer: {
                Text("This is a demo checkout. No real payment is processed.")
            }
        }
        .navigationTitle("Purchase")
        .alert("Order placed!", isPresented: $showConfirmation) {
            Button("Done") {
                dismiss()
            }
        } message: {
            Text("Thanks, \(name). Your meals are on the way 🌟")
        }
    }

    private func placeOrder() {
        placingOrder = true
        // Simulate payment network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            placingOrder = false
            cart.clear()
            showConfirmation = true
        }
    }
}

#Preview {
    NavigationStack { CheckoutView() }
        .environmentObject(CartStore())
}
