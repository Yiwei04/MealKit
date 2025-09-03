//
//  CheckoutView.swift
//  MealKit
//
//  Purpose:
//  --------
//  Purchase/checkout form (contact + delivery). Validates input fields,
//  disables purchase until valid, shows error alerts, simulates payment,
//  then clears the cart and confirms.
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
    @State private var formError: AppError?

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
                if name.trimmingCharacters(in: .whitespaces).isEmpty {
                    Text("Required").font(.caption).foregroundColor(.red)
                }

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                if !email.isEmpty && !isValidEmail(email) {
                    Text("Enter a valid email address").font(.caption).foregroundColor(.red)
                }
            }

            Section("Delivery") {
                TextField("Address", text: $address, axis: .vertical)
                    .lineLimit(3, reservesSpace: true)
                if address.trimmingCharacters(in: .whitespaces).isEmpty {
                    Text("Required").font(.caption).foregroundColor(.red)
                }
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
                .disabled(cart.lines.isEmpty
                          || name.trimmingCharacters(in: .whitespaces).isEmpty
                          || !isValidEmail(email)
                          || address.trimmingCharacters(in: .whitespaces).isEmpty
                          || placingOrder)
            } footer: {
                Text("This is a demo checkout. No real payment is processed.")
            }
        }
        .navigationTitle("Purchase")

        // Error alert for invalid form/cart state
        .alert("Can’t place order",
               isPresented: .constant(formError != nil),
               presenting: formError) { _ in
            Button("OK", role: .cancel) { formError = nil }
        } message: { err in
            Text(err.localizedDescription)
        }

        // Success confirmation
        .alert("Order placed!", isPresented: $showConfirmation) {
            Button("Done") {
                dismiss()
            }
        } message: {
            Text("Thanks, \(name). Your meals are on the way 🌟")
        }
    }


    private func isValidEmail(_ email: String) -> Bool {
        // Simple, readable RFC-lite check
        let pattern = #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        return email.range(of: pattern, options: [.regularExpression, .caseInsensitive]) != nil
    }

    private func placeOrder() {
        // Guard against empty cart and invalid fields with explicit errors
        guard !cart.lines.isEmpty else { formError = .cartIsEmpty; return }
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { formError = .missingName; return }
        guard isValidEmail(email) else { formError = .invalidEmail; return }
        guard !address.trimmingCharacters(in: .whitespaces).isEmpty else { formError = .missingAddress; return }

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
