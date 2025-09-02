//
//  ContentView.swift
//  MealKit
//
//  Created by Jeffery Wang on 27/8/2025.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    // Safely load video from bundle
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
                    
                    // Logo in the middle
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(.white.opacity(0.9))
                                .shadow(color: .gray.opacity(0.7), radius: 2, x: 2, y: 2)
                        )
                    
                    Spacer()
                    
                    // Entry button → goes to Terms screen
                    NavigationLink(destination: TermsView()
                        .navigationBarBackButtonHidden(true)) {
                        Text("Enter")
                            .font(.headline)
                            .foregroundStyle(.green)
                            .frame(width: 200, height: 50)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.white.opacity(0.9))
                                    .shadow(color: .gray.opacity(0.7), radius: 5, x: 0, y: 2)
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
    ContentView()
}
