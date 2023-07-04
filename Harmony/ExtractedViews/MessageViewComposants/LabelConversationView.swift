//
//  LabelConversationView.swift
//  Harmony
//
//  Created by apprenant49 on 23/06/2023.
//

import SwiftUI

struct LabelConversationView: View {
    
    @ObservedObject var conversation : Conversation
    
    var body: some View {
        HStack {
            
            // show icon user
            IconUserView(icon: conversation.user.photo, isConnected: conversation.user.isConnected)
            
            Spacer()
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .top) {
                    
                    // destinataire
                    Text(conversation.user.pseudo)
                        .modifier(Head1())
                    
                    Spacer()
                    
                    // date message
                    Text((conversation.lastMessage() != nil) ? conversation.lastMessage()!.dateToString() : "")
                        .fontWeight(conversation.isRead ? .medium : .bold)
                        .modifier(HeadGray())
                }
                
                HStack(alignment: .top) {
                    // beginning of last message
                    Text((conversation.lastMessage() != nil) ? conversation.lastMessage()!.startMessage(message: (conversation.lastMessage()!.content.typeMessage == .text) ? conversation.lastMessage()!.content.contentText! : "[element partagé]") : "")
                        .modifier(Normal())
                    
                    Spacer()
                    
                    if !conversation.isRead {
                        Text(String(conversation.numberOfMessagesUnread()))
                        
                            .padding(.leading, 5)
                            .padding(.trailing, 5)
                            .foregroundColor(Color.white)
                            .background(Color.darkGray)
                            .fontWeight(.bold)
                            .cornerRadius(50)
                    }
                }
                
            }
            
            
        }
    }
}

/*struct LabelConversationView_Previews: PreviewProvider {
    static var previews: some View {
        LabelConversationView()
    }
}*/
