//
//  KetoMealView.swift
//  MealKit
//
//  Purpose:
//  --------
//  Displays a searchable grid of keto meals.
//
//  Created by Jeffery Wang on 2/9/2025.
//

import SwiftUI

struct KetoMealView: View {
    // Live search string bound to SwiftUI’s search UI.
    @State private var searchText: String = ""
    @EnvironmentObject private var cart: CartStore

    // Returns either the whole set OR the filtered subset by name.
    private var filteredMeals: [Meal] {
        guard !searchText.isEmpty else { return MealSamples.keto }
        return MealSamples.keto.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    // One adaptive column definition = responsive grid sizing.
    private let columns = [GridItem(.adaptive(minimum: 160), spacing: 16)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                // Each meal tile pushes a detail screen via the navigation stack.
                ForEach(filteredMeals) { meal in
                    NavigationLink(destination: MealDetailView(meal: meal)) {
                        MealCardView(meal: meal)
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle("Keto")
        // Built-in search UI
        .searchable(text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: Text("Search meals"))
        .toolbar {
            // Quick access to the cart from Keto view
            NavigationLink(destination: CartView()) {
                CartIcon()
            }
        }
        // On-brand gradient background
        .background(
            LinearGradient(colors: [.green.opacity(0.5), .black],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
        )
    }
}

#Preview {
    NavigationStack { KetoMealView() }
        .environmentObject(CartStore())
}
