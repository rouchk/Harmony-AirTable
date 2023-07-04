//
//  ReactionMessageView.swift
//  Harmony
//
//  Created by apprenant49 on 02/07/2023.
//

import SwiftUI

struct ReactionMessageView: View {
    
    @ObservedObject var user: User
    @ObservedObject var conversation: Conversation
    @ObservedObject var message: Message
    @Binding var isMessageReaction: Bool
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                ForEach (conversation.listEmojisAvailable, id: \.self) { emoji in
                    Button {
                        message.isReaction = false
                        if (message.reaction == emoji) {
                            message.reaction = ""
                        } else {
                            message.reaction = emoji
                        }
                        isMessageReaction = false
                    } label: {
                        Text(emoji)
                            .font(.system(size: (message.reaction == emoji) ? 30 : 20))
                    }
                }
                .listRowSeparator(.hidden)
            }
            .padding(7)
            .frame(width: 300, alignment: .center)
            .background(Color.darkPeriwinkle)
            .cornerRadius(10)
            
            LabelMessageView(user: user, message: message.content)
                .onTapGesture {
                    message.isReaction = false
                    isMessageReaction.toggle()
                }
            Spacer()
        }
        
    }
}
