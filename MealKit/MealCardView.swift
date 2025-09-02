//
//  MealCardView.swift
//  MealKit
//
//  Purpose:
//  --------
//  A reusable tile/card for displaying a single `Meal` in a grid.
//
//  Design:
//  -------
//  - Rounded glassy card with either a meal image or a fork-knife symbol.
//  - Name below the image area, then macro "pills" and price on the right.
//  - Sized to work well inside a LazyVGrid with adaptive columns.
//
//  Created by Jeffery Wang on 2/9/2025.
//

import Foundation
import SwiftUI

struct MealCardView: View {
    let meal: Meal

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Image container
            ZStack {
                // Subtle surface in case the image is absent
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white.opacity(0.12))
                    .frame(height: 110)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(.white.opacity(0.15), lineWidth: 1)
                    )

                if let img = meal.imageName, UIImage(named: img) != nil {
                    Image(img)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 110)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    Image(systemName: "fork.knife.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .foregroundStyle(.white.opacity(0.8))
                }
            }

            // Meal name
            Text(meal.name)
                .font(.headline)
                .foregroundStyle(.white)
                .lineLimit(2)
                .minimumScaleFactor(0.85)

            // Macro pills + price aligned to the trailing edge.
            HStack(spacing: 8) {
                MacroPill(text: "\(meal.protein)g P")
                MacroPill(text: "\(meal.carbs)g C")
                MacroPill(text: "\(meal.fat)g F")
                Spacer()
                // Localised currency, defaulting to AUD if not present.
                Text(meal.price, format: .currency(code: Locale.current.currency?.identifier ?? "AUD"))
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.95))
            }
        }
        .padding(10)
        .background(
            // A glassy container to match the app’s gradient backgrounds.
            RoundedRectangle(cornerRadius: 18)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .strokeBorder(.white.opacity(0.1), lineWidth: 1)
                )
        )
        .shadow(radius: 2, x: 0, y: 1)
    }
}

private struct MacroPill: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.caption2.weight(.semibold))
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(RoundedRectangle(cornerRadius: 8).fill(.white.opacity(0.15)))
            .foregroundStyle(.white)
            .accessibilityLabel(Text(text.replacingOccurrences(of: "g", with: " grams ")))
    }
}

#Preview {
    // Quick visual check: shows a single card on a gradient background.
    ZStack {
        LinearGradient(colors: [.green, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
        MealCardView(meal: MealSamples.keto.first!)
            .padding()
    }
}
