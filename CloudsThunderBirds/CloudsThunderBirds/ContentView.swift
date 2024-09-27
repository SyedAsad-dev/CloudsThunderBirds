//
//  ContentView.swift
//  CloudsThunderBirds
//
//  Created by Rizvi Naqvi on 27/09/2024.
//

import SwiftUI
import Lottie

struct CloudWithRain: View {
    @State private var lightningFlash: Bool = false
    @State private var blackCloudOffsetX: CGFloat = 600 // Initial cloud position
    @State private var whiteCloudOffsetX: CGFloat = 500 //
    @State private var gradientsBrightnessX: CGFloat = 1
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Color
                
                (whiteCloudOffsetX > 150 || blackCloudOffsetX < -400) ?  Color.blue.opacity(0.3)
                    .edgesIgnoringSafeArea(.all) :
                
                Color.black.opacity((lightningFlash || (blackCloudOffsetX < -50 || blackCloudOffsetX > 200)) ? 0.25 : 0.7).edgesIgnoringSafeArea(.all)
                
                
                SunShape(gradientsBrightness: $gradientsBrightnessX)
                
                // Thunder and Rain scene
                ThunderClouds(lightningFlash: $lightningFlash, cloudOffsetX: .constant(0), lightingCloud: .constant(Color.white) , cloudColor:  Color.white.opacity(0.8)).offset(x: whiteCloudOffsetX , y: -330)
                
                
                
                // Thunder and Rain scene
                ThunderClouds(lightningFlash: $lightningFlash, cloudOffsetX: $blackCloudOffsetX, lightingCloud: .constant(Color.white), cloudColor:  Color.gray.opacity(0.8))
                    .offset(x: blackCloudOffsetX, y: -330)

                if lightningFlash {
                    LightningBoltView(cloudOffsetX: $blackCloudOffsetX)
                        .offset(x: blackCloudOffsetX - 50, y: -170) // Adjust lightning position
                    
                    LightningBoltView(cloudOffsetX: $blackCloudOffsetX)
                        .offset(x: blackCloudOffsetX, y: -170) // Adjust lightning position
                    
                    LightningBoltView(cloudOffsetX: $blackCloudOffsetX)
                        .offset(x: blackCloudOffsetX + 50, y: -150) // Adjust lightning position
                }
                
                VStack(spacing: 0) {
                    GrasslandShape()
                        .fill(LinearGradient(gradient: Gradient(colors: [Color.green, Color.green.opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                        
                        
                    Color.blue.opacity(0.3)
                        .edgesIgnoringSafeArea(.all).frame(width: geometry.size.width, height: 15)
                    
                }.frame(width: geometry.size.width,height: 180).offset(y: geometry.size.height - (geometry.size.height / 1.683))
                
               
                
                LottieViewAnimate(cloudOffsetX: $blackCloudOffsetX)
                
                RealisticTreeView(positionX: geometry.size.width / 3, positionY: geometry.size.height - (130))
                
                RealisticTreeView(positionX: geometry.size.width / 2, positionY: geometry.size.height - (100))
                
                RealisticTreeView(positionX: geometry.size.width / 1.5, positionY: geometry.size.height - (125))
                
                RealisticTreeView(positionX: geometry.size.width / 1.3, positionY: geometry.size.height - (105))
                
                RealisticTreeView(positionX: geometry.size.width / 9, positionY: geometry.size.height - (100))
                
                
                RealisticTreeView(positionX: geometry.size.width / 1.05, positionY: geometry.size.height - (128))
                
                
                
            }
            .onAppear {
                startThunder()
                moveClouds()
                
            }
        }
    }
    
    // Lightning Bolt View
    private struct LottieViewAnimate: View {
        @Binding var cloudOffsetX: CGFloat
        @State var isPlaying: Bool = true
        @State var playbackModeAnimation6 = LottiePlaybackMode.paused(at: .time(0.0))
        @State var playbackMode = LottiePlaybackMode.paused(at: .time(0.0))
        var body: some View {
            GeometryReader { geometry in
                ZStack {
                    LottieView(animation: .named("Animation2"))
                        .playing(loopMode:.playOnce).frame(width: 150, height: 150).position(x:geometry.size.width / 2 ,y:geometry.size.height / 1.08)
                    
                    LottieView(animation: .named("Animation4"))
                        .playing(loopMode: .playOnce).position(x:geometry.size.width / 2 ,y:geometry.size.height / 1.5)
                    
                    LottieView(animation: .named("Animation5"))
                        .playing(loopMode: .playOnce).frame(width: 150, height: 150).position(x:geometry.size.width / 5.5 ,y:geometry.size.height / 1.07)
                    
                    if (cloudOffsetX <= -500) {
                        
                        LottieView(animation: .named("Animation6"))
                        .playbackMode(playbackModeAnimation6)
                        .position(x:geometry.size.width / 2 ,y:geometry.size.height / 2.8).onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                                playbackModeAnimation6 = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))

                                }
                            }
                        
                       
                            LottieView(animation: .named("Animation4"))
                            .playbackMode(playbackMode)
                               .position(x:geometry.size.width / 2 ,y:geometry.size.height / 1.5).onAppear {
                                   DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                        playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))

                                    }
                                }
                        
                    
                        
                        LottieView(animation: .named("Animation7"))
                        .playbackMode(playbackMode)
                        .frame(width: 150, height: 150).position(x:geometry.size.width / 2.8 ,y:geometry.size.height / 1.1).onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                                    playbackMode = .playing(.fromProgress(0, toProgress: 1, loopMode: .loop))

                                }
                            }
                          
                        }
                    
                }
            }
        }
    }
    
    // Function to simulate thunderstorm with random lightning flashes
    private func startThunder() {
        Timer.scheduledTimer(withTimeInterval: Double.random(in: 4...8), repeats: true) { _ in
            withAnimation(Animation.easeIn(duration: 0.1).repeatCount(2, autoreverses: true)) {
                lightningFlash.toggle() // Toggle flash effect
                Timer.scheduledTimer(withTimeInterval: Double.random(in: 0.5...2), repeats: false) { _ in
                        lightningFlash.toggle() // Toggle flash effect
                    
                }
            }
        }
    }
    // Function to animate clouds moving left to right
    private func moveClouds() {
  
        withAnimation(Animation.linear(duration: 4)) {
            blackCloudOffsetX = 400 // Move clouds to the right and then reverse
            whiteCloudOffsetX = 0
            gradientsBrightnessX = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                withAnimation(Animation.linear(duration: 4)) {
                    blackCloudOffsetX = 0
                }
                withAnimation(Animation.linear(duration: 6)) {
                    gradientsBrightnessX = 0
                    whiteCloudOffsetX = -450
                    DispatchQueue.main.asyncAfter(deadline: .now() + 20) {
                        withAnimation(Animation.linear(duration: 6)) {
                            blackCloudOffsetX = -600
                            gradientsBrightnessX = 1
                        }

                    }
                }

            }
           
        }
    }
}

// Thunder Cloud View with Lightning Flash
private struct ThunderClouds: View {
    @Binding var lightningFlash: Bool
    @Binding var cloudOffsetX: CGFloat
    @Binding var lightingCloud: Color
    let cloudColor: Color
    var body: some View {
        ZStack {
            CloudShape()
                .fill(lightningFlash ? lightingCloud :cloudColor ) // Flash to white for thunder
                .frame(width: 200, height: 100)
                .offset(x: -90, y: -20)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 180, height: 80)
                .offset(x: -80, y: 20)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 200, height: 100)
                .offset(x: -90, y: 40)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 200, height: 100)
                .offset(x: -50, y: 60)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 200, height: 100)
                .offset(x: 0, y: -20)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 180, height: 80)
                .offset(x: -10, y: 10)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 180, height: 80)
                .offset(x: -30, y: 10)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 220, height: 100)
                .offset(x: 40, y: 30)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 200, height: 100)
                .offset(x: 0, y: 50)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 200, height: 100)
                .offset(x: 100, y: -10)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 180, height: 80)
                .offset(x: 80, y: 30)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 200, height: 100)
                .offset(x: 70, y: 50)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 200, height: 100)
                .offset(x: -50, y: 60)
            
            CloudShape()
                .fill(lightningFlash ? lightingCloud : cloudColor)
                .frame(width: 200, height: 100)
                .offset(x: 50, y: 60)
        }
        .shadow(color: lightningFlash ? lightingCloud : Color.black.opacity(0.5), radius: 10, x: 0, y: 10)
        .padding()
    }
}

private struct SunShape: View {
    @Binding var gradientsBrightness: CGFloat
    var body: some View {
        ZStack {
            // Glowing halo around the sun
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [Color.yellow.opacity(0.8), Color.clear]),
                        center: .center,
                        startRadius: 100 * gradientsBrightness,
                        endRadius: 200 * (gradientsBrightness)
                    )
                )
                .frame(width: 150, height: 150)
                .blur(radius: 15)
            
            // Sun Core
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [Color.yellow.opacity(0.5), Color.orange.opacity(0.5)]),
                        center: .center,
                        startRadius: 20,
                        endRadius: 50
                    )
                )
                .frame(width: 75, height: 75)
                .overlay(
                    Circle()
                        .stroke(Color.yellow.opacity(0.5), lineWidth: 8)
                        .blur(radius: 5)
                )
                .shadow(color: Color.yellow.opacity(0.5), radius: 15, x: 0, y: 0)
        }
        .position(x: 200, y: 100) // Positioning sun in the sky
    }
}

// Custom Cloud Shape
private struct CloudShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Drawing the fluffy cloud shape
        path.move(to: CGPoint(x: rect.minX + 20, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.minX + 20, y: rect.midY - 20), radius: 20, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY - 20), radius: 20, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        path.addArc(center: CGPoint(x: rect.maxX - 20, y: rect.midY), radius: 20, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY + 10), radius: 25, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: false)
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

// Lightning Bolt View
private struct LightningBoltView: View {
    @Binding var cloudOffsetX: CGFloat
    var body: some View {
        ZStack {
            
            // Lightning Bolt Shape
            LightningBoltShape()
                .fill(Color.white)
                .frame(width: 20, height: 80)
                .shadow(color: .yellow, radius: 10, x: 0, y: 10) // Lightning glow effect

        }
    }
}

// Custom Lightning Bolt Shape
private struct LightningBoltShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Draw a jagged lightning bolt shape
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY * 0.5))
        path.addLine(to: CGPoint(x: rect.minX + rect.width * 0.2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX * 0.6, y: rect.maxY * 0.7))
        path.addLine(to: CGPoint(x: rect.maxX * 0.2, y: rect.maxY * 0.9))
        path.closeSubpath()
        
        return path
    }
}


private struct RealisticTreeView: View {
    let positionX: CGFloat
    let positionY: CGFloat
    var body: some View {
        ZStack {
            // Tree Trunk
            RealisticTrunkShape()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.brown, Color.brown.opacity(0.8)]), startPoint: .top, endPoint: .bottom))
                .frame(width: 20, height: 50)
                .offset(y:65)
            
            // Lower Leaf Cluster
            RealisticLeavesShape()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.9), Color.green.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
                .frame(width: 80, height: 60)
                .offset(y: 10)
                .shadow(color: Color.green.opacity(0.8), radius: 20, x: 0, y: 10)
            
            // Middle Leaf Cluster
            RealisticLeavesShape()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.9), Color.green.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
                .frame(width: 70, height: 50)
                .offset(y: -25)
                .shadow(color: Color.green.opacity(0.7), radius: 15, x: 0, y: 5)
            
            // Upper Leaf Cluster
            RealisticLeavesShape()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.9), Color.green.opacity(0.9)]), startPoint: .top, endPoint: .bottom))
                .frame(width: 50, height: 35)
                .offset(y: -55)
                .shadow(color: Color.green.opacity(0.8), radius: 10, x: 0, y: 5)
        }
        .frame(width: 100, height: 180).position(x:positionX,y:positionY)
    }
}

// Custom Shape for Tree Trunk (Realistic)
private struct RealisticTrunkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Drawing a thick and slightly curved tree trunk
        let trunkWidth: CGFloat = rect.width * 0.3
        let trunkHeight = rect.height
        
        path.move(to: CGPoint(x: rect.midX - trunkWidth / 2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - trunkWidth / 1.5, y: rect.minY)) // Left side
        path.addLine(to: CGPoint(x: rect.midX + trunkWidth / 1.5, y: rect.minY)) // Right side
        path.addLine(to: CGPoint(x: rect.midX + trunkWidth / 2, y: rect.maxY)) // Right base
        path.closeSubpath()
        
        return path
    }
}

// Custom Shape for Grassland
private struct GrasslandShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Grassland - create a slightly wavy ground for a natural effect
        let startX: CGFloat = rect.minX
        let startY: CGFloat = rect.maxY * 0.6
        
        path.move(to: CGPoint(x: startX, y: startY))
        path.addQuadCurve(to: CGPoint(x: rect.midX, y: rect.maxY * 0.7),
                          control: CGPoint(x: rect.midX / 2, y: startY - 50))
        path.addQuadCurve(to: CGPoint(x: rect.maxX, y: startY),
                          control: CGPoint(x: rect.midX + rect.midX / 2, y: rect.maxY - 50))
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: startX, y: rect.maxY))
        path.closeSubpath()
        
        return path
    }
}

// Custom Shape for Tree Leaves (Realistic)
private struct RealisticLeavesShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Drawing an oval shape for the leafy clusters of the tree
        path.addEllipse(in: CGRect(x: rect.minX, y: rect.minY, width: rect.width, height: rect.height))
        
        return path
    }
}


#Preview {
    CloudWithRain()
}
