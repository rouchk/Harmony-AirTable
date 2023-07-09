//
//  ChatView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct ChatView: View {
    
    @State var searchMessageByUser : String = ""
    @ObservedObject var users : UsersVM
    @ObservedObject var eventsVM: EventsViewModel
    @ObservedObject var communitiesVM: CommunitiesVM
    
    var body: some View {
        NavigationView {
            VStack {
                if searchResult != nil {
                    if searchResult!.isEmpty {
                        Text("Aucune conversation correspondante")
                    } else {
                        // display conversations based on username search
                        List {
                            ForEach(searchResult!) { conv in
                                ZStack {
                                    LabelConversationView(conversation: conv)
                                    NavigationLink(destination: MessagesView(conversation: conv, user: users.myUser!, eventsVM: eventsVM, usersVM: users, communitiesVM: communitiesVM)) {
                                    }
                                    .opacity(0)
                                }
                            }
                            
                            // delete conversation selected
                            .onDelete { indexSet in
                                users.myUser!.delConversationByIndex(index: indexSet)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
               
            }
            .background(Color.white)
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchMessageByUser, placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher par nom")
            
            /* add conversation screen */
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: AddConversationView(users: users, eventsVM: eventsVM, communitiesVM: communitiesVM))  {
                        Image(systemName: "plus.circle")
                    }
            )
        }
    }
    
    var searchResult: [Conversation]? {
        if users.myUser != nil {
            if !searchMessageByUser.isEmpty {
                return users.myUser!.conversations.filter { conv in
                    conv.user.pseudo.lowercased().contains(searchMessageByUser.lowercased())
                }
            }
            
            return users.myUser!.conversations
        }
        
        return nil
       
    }
}
//
//struct ChatView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatView(user: myUser)
//    }
//}
