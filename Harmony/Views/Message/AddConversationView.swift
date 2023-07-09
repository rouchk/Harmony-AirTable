//
//  AddConversationView.swift
//  Harmony
//
//  Created by apprenant49 on 26/06/2023.
//

import SwiftUI

struct AddConversationView: View {
    @ObservedObject var users : UsersVM
    @ObservedObject var eventsVM: EventsViewModel
    @ObservedObject var communitiesVM: CommunitiesVM
    @State var isChanged : Bool = false
    @State var isAction : Bool = false
    
    var body: some View {
        
        Form {
            Section(header: Text("Commencer une conversation avec...")) {
                List {
                    if (users.myUser != nil) {
                        ForEach (0..<users.myUser!.myContacts.count) { i in
                            if (users.myUser!.searchConversationByUser(user: users.myUser!.myContacts[i]) === nil) {
                                
                                Button {
                                    // add an element conversation in the selected user
                                    users.myUser!.newConversation(user: users.myUser!.myContacts[i], isRead: true)
                                    isAction = true
                                } label: {
                                    HStack {
                                        // show icon user
                                        IconUserView(icon: users.myUser!.myContacts[i].photo, isConnected: users.myUser!.myContacts[i].isConnected)
                                        
                                        Text(users.myUser!.myContacts[i].pseudo)
                                            .padding(.leading, 10)
                                    }
                                    
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        .sheet(isPresented: $isAction) {
            //display a new conversation with the selected user
            NewConversationView(users: users, eventsVM: eventsVM, communitiesVM: communitiesVM, isAction: $isAction)
        }
    }
}
//
//struct AddConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddConversationView(user: myUser)
//    }
//}
