//
//  FaceAnimation.swift
//  Harmony
//
//  Created by apprenant71 on 25/06/2023.
//

import Foundation
import SwiftUI

struct FacesGeometryEffect : GeometryEffect {
    var time : Double
    var speed = Double.random(in: 100 ... 400)
    var xDirection = Double.random(in:  -0.05 ... 0.05)
    var yDirection = Double.random(in: -Double.pi ...  0)
    
    var animatableData: Double {
        get { time }
        set { time = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        let xTranslation = speed * xDirection
        let yTranslation = speed * sin(yDirection) * time
        let affineTranslation =  CGAffineTransform(translationX: xTranslation, y: yTranslation)
        return ProjectionTransform(affineTranslation)
    }
}


struct FaceMovementModifier: ViewModifier {
    @State var time = 0.0
    let duration = 3.0
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .modifier(FacesGeometryEffect(time: time))
                .opacity(time == 3 ? 0 : 1)
        }
        .onAppear {
            withAnimation (.easeOut(duration: duration)) {
                self.time = duration
            }
        }
    }
}


struct FaceAnimationView: View {
    
    @State var faces = 15
    
    func facesAction () {
        faces += 5
    }
    
    
    var body: some View {
        
        ZStack {
            
            Image("gameover")
                .resizable()
                .frame(width: 96, height: 96)
                .padding()
                .onAppear() {
                    facesAction()
                }
            
            ForEach (0..<faces, id: \.self){ _ in
                Image("gameover")
                    .resizable()
                    .frame(width: 96, height: 96)
                    .modifier(FaceMovementModifier())
                    .padding()
            }
            
            Image("gameover")
                .resizable()
                .frame(width: 104, height: 104)
                .font(.largeTitle)
            
            
        }.foregroundColor(.white.opacity(0.5))
        
    }
}
