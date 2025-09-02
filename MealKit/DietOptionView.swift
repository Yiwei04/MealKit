//
//  DietMenuView.swift
//  MealKit
//
//  Created by Jeffery Wang on 2/9/2025.
//

import SwiftUI

// View that displays a menu of diet options
struct DietMenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background color fills entire screen
                Rectangle()
                    .fill(Color.green)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // Keto diet option
                    NavigationLink(destination: KetoMealView()) {
                        MenuCard(title: "Keto", color: .white)
                    }
                    
                    Spacer()
                    
                    // High protein diet option
                    NavigationLink(destination: ProteinMealView()) {
                        MenuCard(title: "High Protein", color: .white)
                    }
                    
                    Spacer()
                    
                    // Low calorie diet option (placeholder for now)
                    NavigationLink(destination: EmptyView()) {
                        MenuCard(title: "Low Calorie", color: .gray)
                    }
                    //Disables the Button
                    .disabled(true)
                    
                    Spacer()
                    
                    // Vegetarian diet option (placeholder for now)
                    NavigationLink(destination: EmptyView()) {
                        MenuCard(title: "Vegetarian", color: .gray)
                    }
                    //Disables the Button
                    .disabled(true)
                    
                    Spacer()
                    
                    // Pescatarian diet option (placeholder for now)
                    NavigationLink(destination: EmptyView()) {
                        MenuCard(title: "Pescatarian", color: .gray)
                    }
                    //Disables the Button
                    .disabled(true)
                    
                    Spacer()
                }
                .padding()
            }
        }
        // Hide back button on root for cleaner UI
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DietMenuView()
}

// MARK: - Reusable card view for menu items
struct MenuCard: View {
    let title: String     // Text label for the diet
    let color: Color      // Background color
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.lightgreen)
            .frame(width: 200, height: 50)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.opacity(0.9))
                    .shadow(color: .gray.opacity(0.7), radius: 5, x: 0, y: 2)
                    .frame(width: 300, height: 80)
            )
    }
}
