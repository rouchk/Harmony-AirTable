//
//  NewConversationView.swift
//  Harmony
//
//  Created by apprenant49 on 28/06/2023.
//

import SwiftUI

struct NewConversationView: View {
    @ObservedObject var users : UsersVM
    @ObservedObject var user : User
    @Binding var isAction : Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                Button {
                    if (user.lastConversation()!.messages.count == 0) {
                        user.delConversationLast()
                    }
                    isAction.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .font(.largeTitle)
                }
                .padding(10)
            }
            MessagesView(conversation: user.lastConversation()!, user: user)
        }
    }
}

//struct NewConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewConversationView()
//    }
//}
