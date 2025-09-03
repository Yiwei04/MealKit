//
//  CartStore.swift
//  MealKit
//
//  Purpose:
//  --------
//  ObservableObject cart state shared across the app: lines (meal + quantity),
//  add/remove/set quantity, aggregates (itemCount, subtotal), and clear().
//
//  Created by Jeffery Wang on 3/9/2025.
//

import Foundation

// A single line in the cart: a meal + quantity.
struct CartLine: Identifiable, Hashable {
    let id = UUID()
    var meal: Meal
    var quantity: Int
    var lineTotal: Double { Double(quantity) * meal.price }
}

final class CartStore: ObservableObject {
    @Published private(set) var lines: [CartLine] = []

    // Add 1 (or more) of a meal to the cart.
    func add(_ meal: Meal, quantity: Int = 1) {
        if let idx = lines.firstIndex(where: { $0.meal.id == meal.id }) {
            lines[idx].quantity += quantity
        } else {
            lines.append(CartLine(meal: meal, quantity: quantity))
        }
    }

    // Update quantity for a given line (clamps to >= 1).
    func setQuantity(for lineID: UUID, quantity: Int) {
        guard let idx = lines.firstIndex(where: { $0.id == lineID }) else { return }
        lines[idx].quantity = max(1, quantity)
    }

    // Remove a line completely.
    func remove(lineID: UUID) {
        lines.removeAll { $0.id == lineID }
    }

    // Empty the cart.
    func clear() {
        lines.removeAll()
    }

    // Aggregates
    var itemCount: Int { lines.reduce(0) { $0 + $1.quantity } }
    var subtotal: Double { lines.reduce(0) { $0 + $1.lineTotal } }
    var currencyCode: String { Locale.current.currency?.identifier ?? "AUD" }
}
