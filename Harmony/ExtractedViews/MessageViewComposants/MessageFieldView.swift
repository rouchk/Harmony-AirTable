//
//  MessageFieldView.swift
//  Harmony
//
//  Created by apprenant49 on 28/06/2023.
//

import SwiftUI

struct MessageFieldView: View {
    @State var newMessage = ""
    @ObservedObject var conversation: Conversation
    @Binding var showingShare: Bool
    @State var iconMessage = "plus.app.fill"
    
    var body: some View {
        HStack {
            HStack {
                TextField("Ecris ton message ici...", text: $newMessage)
                    .frame(height: 16)
                    .cornerRadius(10)
                    .padding(10)
            }
            .padding(.vertical, 10)
            .background(Color.whiteSmoke)
            .cornerRadius(50)
            .padding()

            // button to show the item sharing actions (events, contacts, communities, images) or to send a message text
            Button {
                if (newMessage != "") {
                    conversation.addMessage(new: Message(content: MessageContent(typeMessage: .text, contentText: newMessage), isRecipient: true, date: Date()))
                    newMessage = ""
                } else {
                    showingShare.toggle()
                }
                
            } label: {
                Image(systemName: iconMessage)
                    .font(.system(size: 25))
                    .tint(Color.darkPeriwinkle)
            }
            Spacer()
        }
        .onChange(of: newMessage) { newValue in
            if (newMessage != "") {
                showingShare = false
                iconMessage = "paperplane.fill"
            } else {
                iconMessage = "plus.app.fill"
            }
        }
        
    }
}
