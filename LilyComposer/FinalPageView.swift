import SwiftUI
import AVFoundation

struct FinalPageView: View {
    @State private var isAnimating = false
    @State private var navigateToMap = false
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Image("FinalTexture")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width,
                               height: geometry.size.width)
                    
                    PianoRotatingView()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: -4))
                        .frame(width: geometry.size.width * 0.6,
                               height: geometry.size.width * 0.14)
                        .padding(.top, geometry.size.height * 0.53)
                        .padding(.leading, geometry.size.width * 0.1)
                        .padding(.trailing, geometry.size.width * 0.1)
                    
                    Image("Tuts_1")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: -4))
                        .frame(width: geometry.size.width * 0.08)
                        .padding(.top, geometry.size.height * 0.56)
                        .padding(.leading, geometry.size.width * 0.03)
                        .padding(.trailing, geometry.size.width * 0.3)
                    
                    Image("Tuts_2")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: -4))
                        .frame(width: geometry.size.width * 0.08)
                        .padding(.top, geometry.size.height * 0.8)
                        .padding(.leading, geometry.size.width * 0.6)
                        .padding(.trailing, geometry.size.width * 0.3)
                    
                    
                    Image("Tuts_2")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: -4))
                        .frame(width: geometry.size.width * 0.08)
                        .padding(.top, geometry.size.height * 0.4)
                        .padding(.leading, geometry.size.width * 0.6)
                        .padding(.trailing, geometry.size.width * 0.3)
                    
                    
                    ViolinRotatingView()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 25))
                        .frame(width: geometry.size.width * 0.5,
                               height: geometry.size.width * 0.2)
                        .padding(.top, geometry.size.height * 0.5)
                        .padding(.trailing, geometry.size.width * 0.7)
                    
                    FluteRotatingView()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: 60))
                        .frame(width: geometry.size.width * 0.12,
                               height: geometry.size.width * 0.2)
                        .padding(.top, geometry.size.height * 0.56)
                        .padding(.leading, geometry.size.width * 0.68)
                    
                    
                    VStack (alignment: .center, spacing: 20) {
                        
                        HStack (alignment: .center, spacing: 40){
                            MusicNotRotatingView()
                                .frame(width: geometry.size.width * 0.12,
                                       height: geometry.size.width * 0.2)
                            
                            VStack (alignment: .center, spacing: 20){
                                Image("SongTitle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.4,
                                           height: geometry.size.width * 0.2)
                            }
                            
                        }
                        
                        
                        
                        Button(action: {
                            // Action when the play button is tapped
                            self.isAnimating = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isAnimating = false
                                self.navigateToMap = true
                                FinalAudioManager.shared.stopBackgroundMusic()
                            }
                        }) {
                            Image("ReplayButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.17,
                                       height: geometry.size.width * 0.13)
                                .scaleEffect(isAnimating ? 1.2 : 1.0) // Scale effect on animation
                                .animation(Animation.easeInOut(duration: 0.5), value: isAnimating)
                        }
                        .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the button's default styling
                        
                        NavigationLink(
                            destination: LandingPageView(),
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
        .onAppear {
            FinalAudioManager.shared.playBackgroundMusic()
        }
    }
}

class FinalAudioManager {
    static let shared = FinalAudioManager()
    
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        guard let url = Bundle.main.url(forResource: "TotoroFull", withExtension: "mp3") else {
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
    FinalPageView()
}
