//
//  ConfettiAnimation.swift
//  Harmony
//
//  Created by apprenant71 on 26/06/2023.
//

import Foundation
import SwiftUI
import SpriteKit

class ParticleScene: SKScene {
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = .clear
//        view?.backgroundColor = .clear
//        view?.allowsTransparency = true
        
        if let emitter = SKEmitterNode(fileNamed: "ConfettiParticle") {
            emitter.position.y = size.height
            emitter.particleColorSequence = nil
            emitter.particleColorBlendFactor = 1.0
            emitter.particleColorRedRange = 255
            emitter.particleColorBlueRange = 255
            emitter.particleColorGreenRange = 255
            addChild(emitter)
        }
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ConfettiAnimationView: View {
    
    //    @State var celebrate = false
    
    var body: some View {
        ZStack {
            
            GeometryReader { geo in
                SpriteView(scene: ParticleScene(size: geo.size), options: [.allowsTransparency])
                
            }
            
            //
            //            VStack {
            //
            //                 Button {
            //                    celebrate = true
            //                } label: {
            //                    Text("Bravo")
            //                        .font(.largeTitle)
            //                        .foregroundColor(.pink)
            //                }
            //            }
            
        }
    }
}
