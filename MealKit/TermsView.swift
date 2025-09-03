//  TermsView.swift
//  MealKit
//
//  Purpose:
//  --------
//  Shows terms & conditions with video background. “Agree” navigates into the app flow (DietOptionView). Keeps UI simple and readable.
//
//  Created by Jeffery Wang on 2/9/2025.
//

import SwiftUI
import UIKit
import AVFoundation

// View that displays the terms & conditions with a looping video background
struct TermsView: View {
    // Load video from the app bundle to be used as the background
    private let player: AVPlayer? = {
        if let url = Bundle.main.url(forResource: "StarBackground", withExtension: "mp4") {
            return AVPlayer(url: url)
        }
        return nil
    }()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Full-screen looping background video (only if available)
                if let player = player {
                    VideoBackgroundPlayer(player: player)
                        .ignoresSafeArea()
                }
                VStack {
                    Spacer()
                    // Logo placeholder (replace with your logo view if available)
                    // Image("AppLogo").resizable().scaledToFit().frame(width: 120, height: 120)
                    Spacer()
                    
                    // Terms & Conditions message
                    Text("""
                         By using MealKit, you agree to:

                         1. Subscriptions renew until canceled.
                         2. Deliveries become your responsibility once received.
                         3. We provide allergen info but cannot guarantee no cross-contamination.
                         4. Cancel anytime before your next billing cycle.
                         5. Refunds only for damaged/missing items (within 48 hrs).
                         6. Don’t misuse the app or services.
                         7. Liability is limited to the amount paid for your order.
                         """)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.green)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .shadow(color: .gray.opacity(1), radius: 5, x: 0, y: 2)
                                .frame(width: 360, height: 400)
                        )
                    
                    Spacer()
                    
                    // Navigation link to continue to the app if user agrees
                    NavigationLink(destination: DietOptionView()) {
                        Text("Agree")
                            .font(.headline)
                            .foregroundStyle(.green)
                            .frame(width: 200, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.white)
                                    .opacity(0.9)
                                    .shadow(color: .gray.opacity(1), radius: 5, x: 0, y: 2)
                            )
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

#Preview {
    NavigationStack { TermsView() }
        .environmentObject(CartStore())
}

