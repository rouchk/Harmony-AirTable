//
//  AddConversationView.swift
//  Harmony
//
//  Created by apprenant49 on 26/06/2023.
//

import SwiftUI

struct AddConversationView: View {
    @ObservedObject var user : User
    @State var isChanged : Bool = false
    @State var isAction : Bool = false
    
    var body: some View {
        
        Form {
            Section(header: Text("Commencer une conversation avec...")) {
                List {
                    ForEach (0..<user.myContacts.count) { i in
                        if (user.searchConversationByUser(user: user.myContacts[i]) === nil) {
                            
                            Button {
                                // add an element conversation in the selected user
                                user.newConversation(user: user.myContacts[i], isRead: true)
                                isAction = true
                            } label: {
                                HStack {
                                    // show icon user
                                    IconUserView(icon: user.myContacts[i].photo, isConnected: user.myContacts[i].isConnected)
                                    
                                    Text(user.myContacts[i].pseudo)
                                        .padding(.leading, 10)
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isAction) {
            //display a new conversation with the selected user
            NewConversationView(users: users, user: user, isAction: $isAction)
        }
    }
}

struct AddConversationView_Previews: PreviewProvider {
    static var previews: some View {
        AddConversationView(user: myUser)
    }
}
