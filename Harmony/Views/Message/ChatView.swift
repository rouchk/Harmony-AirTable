//
//  ChatView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct ChatView: View {
    
    @State var searchMessageByUser : String = ""
    @ObservedObject var user : User
    
    var body: some View {
        NavigationView {
            VStack {
                if searchResult.isEmpty {
                    Text("Aucune conversation correspondante")
                } else {
                    // display conversations based on username search
                    List {
                        ForEach(searchResult) { conv in
                            ZStack {
                                LabelConversationView(conversation: conv)
                                NavigationLink(destination: MessagesView(conversation: conv, user: user)) {
                                }
                                .opacity(0)
                            }
                        }
                        
                        // delete conversation selected
                        .onDelete { indexSet in
                            user.delConversationByIndex(index: indexSet)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .background(Color.white)
            .navigationTitle("Messages")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchMessageByUser, placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher par nom")
            
            /* add conversation screen */
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: AddConversationView(user: myUser))  {
                        Image(systemName: "plus.circle")
                    }
            )
        }
    }
    
    var searchResult: [Conversation] {
        if !searchMessageByUser.isEmpty {
            return user.conversations.filter { conv in
                conv.user.pseudo.lowercased().contains(searchMessageByUser.lowercased())
            }
        }
        
        return user.conversations
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: myUser)
    }
}
