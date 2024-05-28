import SwiftUI
import AVFoundation

struct LandingPageView: View {
    @State private var isAnimating = false
    @State private var navigateToMap = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image("LandingTexture")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width,
                               height: geometry.size.width)
                    
                    Image("PianoAndTuts")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 8.94))
                        .frame(width: geometry.size.width * 0.8,
                               height: geometry.size.width * 0.24)
                        .padding(.top, geometry.size.height * 0.6)
                        .padding(.leading, geometry.size.width * 0.7)
                        .padding(.trailing, geometry.size.width * 0.1)
                    
                    Image("HouseAndCuni")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 0))
                        .frame(width: geometry.size.width * 0.6,
                               height: geometry.size.width * 0.2)
                        .padding(.top, geometry.size.height * 0.6)
                        .padding(.trailing, geometry.size.width * 0.6)
                    
                    Image("Violin")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 25))
                        .frame(width: geometry.size.width * 0.5,
                               height: geometry.size.width * 0.12)
                        .padding(.bottom, geometry.size.height * 0.5)
                        .padding(.trailing, geometry.size.width * 0.8)
                    
                    Image("Flute")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 60))
                        .frame(width: geometry.size.width * 0.1,
                               height: geometry.size.width * 0.08)
                        .padding(.top, geometry.size.height * 0.16)
                        .padding(.trailing, geometry.size.width * 0.5)
                    
                    Image("Trumpet")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: -10))
                        .frame(width: geometry.size.width * 0.5,
                               height: geometry.size.width * 0.14)
                        .padding(.bottom, geometry.size.height * 0.4)
                        .padding(.leading, geometry.size.width * 0.78)
                    
                    VStack (alignment: .center, spacing:  geometry.size.height * 0) {
                        VStack (alignment: .center, spacing: 20){
                            TitleRotatingView()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.5,
                                       height: geometry.size.width * 0.3)
                                .padding(.top, geometry.size.width * 0.1)
                        }
                        
                        Button(action: {
                            // Action when the play button is tapped
                            self.isAnimating = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isAnimating = false
                                self.navigateToMap = true // Set navigateToMap to true after animation
                                AudioManager.shared.stopBackgroundMusic() // Stop music when navigating
                            }
                        }) {
                            Image("PlayButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.1,
                                       height: geometry.size.width * 0.13)
                                .scaleEffect(isAnimating ? 1.2 : 1.0) // Scale effect on animation
                                .animation(Animation.easeInOut(duration: 0.5), value: isAnimating)
                        }
                        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the button's default styling
                        
                        NavigationLink(
                            destination: GamePlayView(posX: 614, posY: 500),
                            isActive: $navigateToMap,
                            label: {
                                EmptyView()
                            }
                        )
                    }.padding(.bottom, geometry.size.height * 0.33)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            .background(Color(red: 1, green: 0.93, blue: 0.97))
            .edgesIgnoringSafeArea(.all) // Optional, to ignore safe area insets
            .navigationBarBackButtonHidden(true)
        }
//        .onAppear {
//            AudioManager.shared.playBackgroundMusic()
//        }
    }
}

class AudioManager {
    static let shared = AudioManager()
    
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "openingSong", withExtension: "mp3") else {
            print("Background music file not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1 // Set to loop indefinitely
            audioPlayer?.play()
        } catch {
            print("Error playing background music: \(error.localizedDescription)")
        }
    }
    
    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }
}

#Preview {
    LandingPageView()
}
