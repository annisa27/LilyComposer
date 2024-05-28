//
//  TutorialsView.swift
//  LittleComposer
//
//  Created by Annisa Az Zahra on 20/05/24.
//

import SwiftUI

struct TutorialsView: View {
    @State private var isAnimating = false
    @State private var navigateToMap = false
    
    @State private var modalsOpacity = 1.0
    @State private var bgOpacity = 0.2
    
    var body: some View {
        GeometryReader { geometry in
            ZStack (alignment: .center){
                Image("Tutorials")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.width * 0.6)
                
                VStack (alignment: .center, spacing: 36){
                    HStack {
                        ViolinRotatingView()
                            .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.12)
                        
                        PianoRotatingView()
                            .frame(width: geometry.size.width * 0.1, height: geometry.size.width * 0.1)
                        
                        FluteRotatingView()
                            .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.1)
                    }
                    
                    Image("TutorialText")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.5)
                    
                    Button(action: {
                        // Action when the play button is tapped
                        self.isAnimating = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.isAnimating = false
                            self.navigateToMap = true // Set navigateToMap to true after animation
                        }
                    }) {
                        Image("StartButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.3)
                            .scaleEffect(isAnimating ? 1.2 : 1.0) // Scale effect on animation
                            .onTapGesture {
                                modalsOpacity = 0.0
                                bgOpacity = 0.0
                            }
                            .animation(Animation.easeInOut(duration: 0.5), value: isAnimating)
                    }
                    .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the button's default styling
                }
                
            }
            .opacity(modalsOpacity)
            .padding(.leading, 300)
            .padding(.top, 90)
        }
        .background(Color(red: 1, green: 0.93, blue: 0.97).opacity(bgOpacity))
        .animation(Animation.easeInOut(duration: 0.5), value: isAnimating)
    }
}

#Preview {
    TutorialsView()
}
