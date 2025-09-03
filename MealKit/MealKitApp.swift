//
//  MealKitApp.swift
//  MealKit
//
//  Purpose:
//  --------
//  App entry point. Creates the single shared CartStore and injects it into
//  the view hierarchy. Launches ContentView inside the app’s main window.
//
//  Created by Jeffery Wang on 27/8/2025.
//

import SwiftUI

@main
struct MealKitApp: App {
    @StateObject private var cart = CartStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cart)
        }
    }
}
