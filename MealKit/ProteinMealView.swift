//
//  ProteinMealView.swift
//  MealKit
//
//  Purpose:
//  --------
//  Displays a searchable grid of *high-protein* meals using `MealCardView`.
//  Structure matches `KetoMealView` for consistency and easy maintenance.
//
//  Created by Jeffery Wang on 2/9/2025.
//

import SwiftUI

struct ProteinMealView: View {
    @State private var searchText: String = ""

    private var filteredMeals: [Meal] {
        guard !searchText.isEmpty else { return MealSamples.highProtein }
        return MealSamples.highProtein.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    private let columns = [GridItem(.adaptive(minimum: 160), spacing: 16)]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(filteredMeals) { meal in
                    NavigationLink(destination: MealDetailView(meal: meal)) {
                        MealCardView(meal: meal)
                    }
                }
            }
            .padding(16)
        }
        .navigationTitle("High Protein")
        .searchable(
            text: $searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: Text("Search meals")
        )
        .background(
            LinearGradient(colors: [.mint.opacity(0.5), .black],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
        )
    }
}

#Preview {
    NavigationStack { ProteinMealView() }
}
