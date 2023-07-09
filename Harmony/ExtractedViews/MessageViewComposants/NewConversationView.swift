//
//  NewConversationView.swift
//  Harmony
//
//  Created by apprenant49 on 28/06/2023.
//

import SwiftUI

struct NewConversationView: View {
    @ObservedObject var users : UsersVM
    @ObservedObject var eventsVM: EventsViewModel
    @ObservedObject var communitiesVM: CommunitiesVM
    @Binding var isAction : Bool
    
    var body: some View {
        VStack {
            if users.myUser != nil {
                HStack {
                    Spacer()
                    
                    Button {
                        if (users.myUser!.lastConversation()!.messages.count == 0) {
                            users.myUser!.delConversationLast()
                        }
                        isAction.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.largeTitle)
                    }
                    .padding(10)
                }
                MessagesView(conversation: users.myUser!.lastConversation()!, user: users.myUser!, eventsVM: eventsVM, usersVM: users, communitiesVM: communitiesVM)
            }
        }
    }
}

//struct NewConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewConversationView()
//    }
//}
