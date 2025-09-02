//
//  Meal.swift
//  MealKit
//
//  Purpose:
//  --------
//  Defines the core data model for a "Meal" and provides sample data sets used
//  by KetoMealView and ProteinMealView.
//
//  Created by Jeffery Wang on 2/9/2025.
//

import Foundation

struct Meal: Identifiable, Codable, Hashable {
    // Stable unique id for lists and navigation
    let id: UUID

    // Display name, e.g., "Keto Chicken Caesar Bowl".
    var name: String

    var imageName: String?

    // Approximate calories for quick comparison on detail.
    var calories: Int

    // Macronutrients (grams).
    var protein: Int
    var carbs: Int
    var fat: Int

    // Price of a single meal item.
    var price: Double

    // Free-form tags: "keto", "vegetarian", "pescatarian", "gluten-free", etc.
    var tags: [String]

    init(
        id: UUID = UUID(),
        name: String,
        imageName: String? = nil,
        calories: Int,
        protein: Int,
        carbs: Int,
        fat: Int,
        price: Double,
        tags: [String] = []
    ) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.calories = calories
        self.protein = protein
        self.carbs = carbs
        self.fat = fat
        self.price = price
        self.tags = tags
    }
}

struct MealSamples {
    // Keto-friendly meals. If you later enforce a "carb ceiling" in views,
    // these are designed to sit close to typical keto macros.
    static let keto: [Meal] = [
        Meal(name: "Keto Chicken Caesar Bowl", imageName: nil, calories: 520, protein: 42, carbs: 9,  fat: 35, price: 12.99, tags: ["keto","gluten-free"]),
        Meal(name: "Zucchini Noodles & Pesto", imageName: nil, calories: 480, protein: 18, carbs: 11, fat: 38, price: 11.49, tags: ["keto","vegetarian"]),
        Meal(name: "Beef & Broccoli Stir-fry", imageName: nil, calories: 560, protein: 40, carbs: 10, fat: 38, price: 13.49, tags: ["keto"]),
        Meal(name: "Salmon & Avocado Salad", imageName: nil, calories: 510, protein: 34, carbs: 8,  fat: 38, price: 14.49, tags: ["keto","pescatarian"]),
        Meal(name: "Creamy Mushroom Chicken", imageName: nil, calories: 590, protein: 44, carbs: 8,  fat: 43, price: 12.99, tags: ["keto"]),
        Meal(name: "Halloumi Greek Bowl",      imageName: nil, calories: 540, protein: 23, carbs: 12, fat: 41, price: 11.99, tags: ["keto","vegetarian"])
    ]

    /// High-protein meals (not necessarily keto). Great for athletes or as
    /// a "gain/loss" macro target starting point.
    static let highProtein: [Meal] = [
        Meal(name: "Teriyaki Chicken Power Bowl", imageName: nil, calories: 620, protein: 50, carbs: 55, fat: 18, price: 12.49, tags: ["high-protein"]),
        Meal(name: "Lean Beef Burrito",           imageName: nil, calories: 680, protein: 48, carbs: 62, fat: 22, price: 12.99, tags: ["high-protein"]),
        Meal(name: "Tuna Poke Bowl",              imageName: nil, calories: 540, protein: 46, carbs: 52, fat: 12, price: 13.49, tags: ["high-protein","pescatarian"]),
        Meal(name: "Chicken Pesto Pasta",         imageName: nil, calories: 700, protein: 47, carbs: 64, fat: 22, price: 12.99, tags: ["high-protein"]),
        Meal(name: "BBQ Turkey Meatballs",        imageName: nil, calories: 580, protein: 45, carbs: 48, fat: 16, price: 11.99, tags: ["high-protein"]),
        Meal(name: "Greek Yoghurt Parfait",       imageName: nil, calories: 420, protein: 32, carbs: 44, fat: 10, price:  8.99, tags: ["high-protein","vegetarian"])
    ]
}
