//
//  MealDetailView.swift
//  MealKit
//
//  Purpose:
//  --------
//  Shows a detailed view of a single `Meal` with image area, macros, calories,
//  tags, and an "Add to kit" action stub. Uses simple, readable layout that
//  ties into the gradient/glass theme used elsewhere.
//
//  Created by Jeffery Wang on 2/9/2025.
//

import SwiftUI

struct MealDetailView: View, Hashable {
    static func == (lhs: MealDetailView, rhs: MealDetailView) -> Bool { lhs.meal.id == rhs.meal.id }
    func hash(into hasher: inout Hasher) { hasher.combine(meal.id) }
    @EnvironmentObject private var cart: CartStore
    @State private var showAdded = false

    let meal: Meal

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Hero image section with placeholder.
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.ultraThinMaterial)
                        .frame(height: 200)

                    if let img = meal.imageName, UIImage(named: img) != nil {
                        Image(img)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 64, height: 64)
                            .foregroundStyle(.white.opacity(0.9))
                    }
                }
                
                // Name
                Text(meal.name)
                    .font(.title2.weight(.bold))
                    .foregroundStyle(.white)
                    .accessibilityAddTraits(.isHeader)

                // Macro + calories summary. Label icons communicate quickly.
                HStack(spacing: 12) {
                    Label("\(meal.calories) kcal", systemImage: "flame")
                    Label("\(meal.protein)g protein", systemImage: "bolt.fill")
                    Label("\(meal.carbs)g carbs",    systemImage: "leaf")
                    Label("\(meal.fat)g fat",        systemImage: "drop")
                }
                .foregroundStyle(.white.opacity(0.9))
                .labelStyle(.titleAndIcon)

                if !meal.tags.isEmpty {
                    Text("Tags: \(meal.tags.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))
                }

                Button {
                    cart.add(meal) 
                    showAdded = true
                } label: {
                    HStack {
                        Image(systemName: "cart.badge.plus")
                        Text("Add to kit • " + (Locale.current.currency?.identifier ?? "AUD"))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.white.opacity(0.15))
                    )
                }
                .foregroundStyle(.white)
                .accessibilityHint(Text("Adds \(meal.name) to your meal kit"))
            }
            .padding()
        }
        .background(
            LinearGradient(colors: [.green.opacity(0.5), .black],
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
        )
        .navigationTitle("Meal details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Quick access to the cart from detail screen
            NavigationLink(destination: CartView()) {
                CartIcon()
            }
        }
        .alert("Added to cart", isPresented: $showAdded) {   
            Button("Keep browsing", role: .cancel) { }
            // This pushes Cart on the same NavigationStack
            NavigationLink("Go to Cart", destination: CartView())
        } message: {
            Text("“\(meal.name)” has been added to your cart.")
        }
    }
}

#Preview {
    NavigationStack { MealDetailView(meal: MealSamples.keto.first!) }
        .environmentObject(CartStore())
}
