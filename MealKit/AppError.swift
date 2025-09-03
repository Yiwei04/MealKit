//
//  AppError.swift
//  MealKit
//
//  Purpose:
//  --------
//  Centralised error types and user-facing messages used across the app.
//
//  Created by Jeffery Wang on 4/9/2025.
//

import Foundation

enum AppError: LocalizedError, Equatable {
    // Cart errors
    case invalidQuantity
    case maxPerItemExceeded(limit: Int)
    case lineNotFound
    case cartIsEmpty

    // Checkout/form errors
    case invalidEmail
    case missingName
    case missingAddress

    var errorDescription: String? {
        switch self {
        case .invalidQuantity:
            return "Quantity must be at least 1."
        case .maxPerItemExceeded(let limit):
            return "You can only add up to \(limit) of the same meal."
        case .lineNotFound:
            return "We couldn’t find that item in your cart."
        case .cartIsEmpty:
            return "Your cart is empty."
        case .invalidEmail:
            return "Please enter a valid email address."
        case .missingName:
            return "Please enter your full name."
        case .missingAddress:
            return "Please enter your delivery address."
        }
    }
}
