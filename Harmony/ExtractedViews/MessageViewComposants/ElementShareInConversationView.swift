//
//  ElementShareInConversationView.swift
//  Harmony
//
//  Created by apprenant49 on 30/06/2023.
//

import SwiftUI

struct ElementShareInConversationView: View {
    var elementName : String
    var elementImg : String
    @Binding var elementChange : Bool
    
    var body: some View {
        VStack {
            Button {
                elementChange.toggle()
            } label: {
                Image(systemName: elementImg)
                    .tint(Color.white)
                    .font(.system(size: 20))
            }
            .frame(width: 50, height: 50)
            .background(Color.darkPeriwinkle)
            .cornerRadius(15)
            
            Text(elementName)
                .modifier(Small())
        }
        
    }
}

//struct ElementShareInConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ElementShareInConversationView()
//    }
//}
