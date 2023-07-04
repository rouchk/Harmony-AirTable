//
//  MapPinVIew.swift
//  Harmony
//
//  Created by apprenant71 on 27/06/2023.
//

import Foundation
import SwiftUI

struct MapPinView: View {
    
    var body: some View {
        
        ZStack {
            Image(systemName: "triangle.fill")
                .rotationEffect(.degrees(180))
                .offset(x: 0.16, y: 7.5)
                .font(.system(size: 10))
            
            Image(systemName: "circle.fill")
                .offset(x: 0, y: -2)
                .font(.system(size: 16))
            
            Image(systemName: "circle.fill")
                .offset(x: 0, y: -2)
                .font(.system(size: 6))
                .foregroundColor(.white)
        }
    }
}
