//
//  GamePlayView.swift
//  LilyComposer
//
//  Created by Annisa Az Zahra on 22/05/24.
//

import SwiftUI
import AVFoundation

struct GamePlayView: View {
    @State private var isAnimating = false
    @State private var navigateToMap = false
    
    @State var posX: Double
    @State var posY: Double
    
    @State private var violinBarOpacity = 0.0
    @State private var pianoBarOpacity = 0.0
    @State private var fluteBarOpacity = 0.0
    
    @State private var violinOpacity = 1.0
    @State private var pianoOpacity = 1.0
    @State private var fluteOpacity = 1.0
    
    @State private var buttonReveal: String = "RevealButtonDisable"
    
    // Audio players
    @State private var violinPlayer: AVAudioPlayer?
    @State private var pianoPlayer: AVAudioPlayer?
    @State private var flutePlayer: AVAudioPlayer?
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack{
                    Image("GamePlayMaps")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width,
                               height: geometry.size.height)
                    
                    ViolinRotatingView()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.3,
                               height: geometry.size.height * 0.17)
                        .padding(.bottom, geometry.size.height * 0.7)
                        .padding(.trailing, geometry.size.height * 0.4)
                        .onTapGesture {
                            violinBarOpacity = 1.0
                            violinOpacity = 0.0
                            violinPlayer?.setVolume(0.2, fadeDuration: 1.0)
                        }
                        .opacity(violinOpacity)
                    
                    FluteRotatingView()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.3,
                               height: geometry.size.height * 0.104)
                        .padding(.top, geometry.size.height * 0.3)
                        .padding(.trailing, geometry.size.height * 0.8)
                        .onTapGesture {
                            fluteBarOpacity = 1.0
                            fluteOpacity = 0.0
                            flutePlayer?.setVolume(1.0, fadeDuration: 1.0)
                        }
                        .opacity(fluteOpacity)
                    
                    PianoRotatingView()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.3,
                               height: geometry.size.height * 0.14)
                        .padding(.top, geometry.size.height * 0.32)
                        .padding(.leading, geometry.size.height * 0.74)
                        .onTapGesture {
                            pianoBarOpacity = 1.0
                            pianoOpacity = 0.0
                            pianoPlayer?.setVolume(1.0, fadeDuration: 1.0)
                        }
                        .opacity(pianoOpacity)
                    
                    Image("CharaFront_1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width / 10,
                               height: geometry.size.height / 10)
                        .position(x: posX, y: posY)
                    
                    ZStack{
                        HStack (spacing: 24){
                            Image("TaskBarEmpty")
                                .resizable()
                                .scaledToFit()
                                .frame(height: geometry.size.height * 0.16)
                            
                            Button(action: {
                                // Action when the play button is tapped
                                self.isAnimating = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.isAnimating = false
                                    self.navigateToMap = true
                                    violinPlayer?.stop()
                                    flutePlayer?.stop()
                                    pianoPlayer?.stop()
                                }
                            }) {
                                Image(buttonReveal)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: geometry.size.height * 0.16)
                                    .onChange(of: [violinBarOpacity, pianoBarOpacity, fluteBarOpacity]) {
                                        if violinBarOpacity == 1.0 && pianoBarOpacity == 1.0 && fluteBarOpacity == 1.0 {
                                            buttonReveal = "RevealButton"
                                        }
                                    }
                            }
                            .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to remove the button's default styling
                            .disabled(buttonReveal == "RevealButton" ? false : true)
                            NavigationLink(
                                destination: FinalPageView(),
                                isActive: $navigateToMap,
                                label: {
                                    EmptyView()
                                }
                            )
                        }.padding(.top, geometry.size.height * 0.7)
                        
                        Image("TaskBarViolin")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height * 0.1)
                            .padding(.top, geometry.size.height * 0.7)
                            .padding(.trailing, geometry.size.height * 0.72)
                            .opacity(violinBarOpacity)
                        
                        Image("TaskBarPiano")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height * 0.08)
                            .padding(.top, geometry.size.height * 0.7)
                            .padding(.trailing, geometry.size.height * 0.38)
                            .opacity(pianoBarOpacity)
                        
                        Image("TaskBarFlute")
                            .resizable()
                            .scaledToFit()
                            .frame(height: geometry.size.height * 0.068)
                            .padding(.top, geometry.size.height * 0.7)
                            .padding(.trailing, geometry.size.height * 0.04)
                            .opacity(fluteBarOpacity)
                    }
                }
                
                ZStack{
                    
                    TutorialsView()
                }
            }
            .background(Color(red: 1, green: 0.93, blue: 0.97))
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
            .onAppear {
                setupAudio()
            }
        }
    }
    
    // Function to setup audio players
    private func setupAudio() {
        violinPlayer = setupPlayer(fileName: "violin")
        pianoPlayer = setupPlayer(fileName: "piano")
        flutePlayer = setupPlayer(fileName: "flute")
        
        violinPlayer?.play()
        pianoPlayer?.play()
        flutePlayer?.play()
    }
    
    
    // Helper function to create an AVAudioPlayer
    private func setupPlayer(fileName: String) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("Could not find \(fileName).mp3")
            return nil
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1 // Loop indefinitely
            player.volume = 0.0 // Start with volume 0
            return player
        } catch {
            print("Error initializing \(fileName) player: \(error.localizedDescription)")
            return nil
        }
    }
}

#Preview {
    GamePlayView(posX: 614, posY: 500)
}
