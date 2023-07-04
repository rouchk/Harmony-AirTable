//
//  IconUserView.swift
//  Harmony
//
//  Created by apprenant49 on 23/06/2023.
//

import SwiftUI

struct IconUserView: View {
    let icon : String
    let isConnected : Bool?
    
    init(icon: String, isConnected: Bool? = nil) {
        self.icon = icon
        self.isConnected = isConnected
    }
    
    var body: some View {
        Image(icon)
            .resizable()
            .scaledToFill()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .overlay {
                if (isConnected != nil) {
                    if isConnected! {
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color.green)
                    }
                }
            }
    }
}

struct IconUserView_Previews: PreviewProvider {
    static var previews: some View {
        IconUserView(icon: "person.crop.circle.fill")
    }
}
