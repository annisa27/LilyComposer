//
//  ViolingRotatingView.swift
//  LittleComposer
//
//  Created by Annisa Az Zahra on 20/05/24.
//

import SwiftUI

struct TitleRotatingView: View {
    @State private var isRotatedRight = true
    let rotationAngle: Double = 3.0
    let animationDuration: Double = 1.0
    
    var body: some View {
        Image("Title")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .rotationEffect(Angle(degrees: isRotatedRight ? rotationAngle : -rotationAngle))
            .onAppear {
                // Start the animation loop
                rotate()
            }

    }
    func rotate() {
        withAnimation(Animation.easeInOut(duration: animationDuration)) {
            // Toggle the rotation direction
            self.isRotatedRight.toggle()
        }

        // Schedule the next rotation
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            rotate()
        }
    }
}

#Preview {
    TitleRotatingView()
}
