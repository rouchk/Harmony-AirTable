//
//  MessagesView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct MessagesView: View {
    
    @ObservedObject var conversation : Conversation
    @ObservedObject var user : User
    
    @State var showingShare = false
    @State var newMessage : String = ""
    @State var eventsShare : Bool = false
    @State var imgsShare : Bool = false
    @State var commsShare : Bool = false
    @State var contactsShare : Bool = false
    @State var isMessageReaction : Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                // display conversation normal if there isn't triggered reaction to a message
                if (!isMessageReaction) {
                    
                    // display all messages in a conversation
                    //List {
                    ScrollView {
                        VStack {
                            ForEach(conversation.messages) { message in
                                    
                                    // if the reference user is the sender don't display photo user
                                    if (message.isRecipient) {
                                        ZStack(alignment: .bottomLeading) {
                                            
                                            // if the message type is text, we can use the reactions system
                                            if (message.content.typeMessage == .text) {
                                                LabelMessageView(user: user, message: message.content, date: message.dateToString())
                                                    .onLongPressGesture {
                                                            message.isReaction = true
                                                            isMessageReaction.toggle()
                                                    }
                                                
                                                if message.reaction != "" {
                                                    Text(message.reaction)
                                                        .offset(x:10, y:-3)
                                                }
                                            } else {
                                                LabelMessageView(user: user, message: message.content, date: message.dateToString())
                                            }
                                            
                                        }
                                    } else {
                                        ZStack(alignment: .bottomLeading) {
                                            
                                            // if the message type is text, we can use the reactions system
                                            if (message.content.typeMessage == .text) {
                                                LabelMessageView(user: user, message: message.content, date: message.dateToString(), iconDestinataire: conversation.user.photo)
                                                    .onLongPressGesture {
                                                            message.isReaction = true
                                                            isMessageReaction.toggle()
                                                        }
                                                
                                                if message.reaction != "" {
                                                    Text(message.reaction)
                                                        .offset(x:110, y:-3)
                                                }
                                            } else {
                                                LabelMessageView(user: user, message: message.content, date: message.dateToString(), iconDestinataire: conversation.user.photo)
                                            }
                                        }
                                    }
                                }
                                .listRowSeparator(.hidden)
                            .padding(.bottom, 5)
                        }
                    }
//                    }
//                    .listStyle(.plain)
                    
                    Spacer()
                    
                    Divider()
                    
                    HStack {
                        
                        // display the widget for typing a new message
                        MessageFieldView(conversation: conversation, showingShare: $showingShare)
                    }
                    
                    HStack {
                        
                        // display the item sharing actions
                        if showingShare {
                            HStack(alignment: .top) {
                                ElementShareInConversationView(elementName: "Contacts", elementImg: "person.circle", elementChange: $contactsShare)
                                    .frame(width: 80)
                                ElementShareInConversationView(elementName: "Evenements", elementImg: "calendar", elementChange: $eventsShare)
                                    .frame(width: 80)
                                ElementShareInConversationView(elementName: "Communauté", elementImg: "globe", elementChange: $commsShare)
                                    .frame(width: 80)
                                ElementShareInConversationView(elementName: "Images", elementImg: "photo.on.rectangle.angled", elementChange: $imgsShare)
                                    .frame(width: 80)
                            }
                        }
                    }
                    
                // display the message with the different reactions available
                } else {
                    ReactionMessageView(user: user, conversation: conversation, message: conversation.MessageWaitingForAResponse()!, isMessageReaction: $isMessageReaction)
                }
                
            }
            .padding(.top, 10)
            .navigationBarBackButtonHidden(!isMessageReaction ? false : true)
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .principal) {
                    if (!isMessageReaction) {
                        LabelUserView(user: conversation.user)
                            .padding(.bottom, 20)
                        
                            Divider()
                    }
                }
            }
            
            // modal which displays the list of events to share
            .sheet(isPresented: $eventsShare) {
                Form {
                    Section(header: Text("Partager un des événements à venir")) {
                        List {
                            ForEach(user.events) { event in
                                //if (event.date >= Date()) {
                                Button {
                                    conversation.addMessage(new: Message(content: MessageContent(typeMessage: .event, contentEvent: event), isRecipient: true, date: Date()))
                                    eventsShare.toggle()
                                } label: {
                                    EventListRowView(myEvent: event)
                                }
                                    
                                //}
                            }
                        }
                    }
                }
            }
            
            // modal which displays the list of contacts to share
            .sheet(isPresented: $contactsShare) {
                Form {
                    Section(header: Text("Partager un contact")) {
                        List {
                            ForEach(user.myContacts) { contact in
                                if (contact !== conversation.user) {
                                    Button {
                                        conversation.addMessage(new: Message(content: MessageContent(typeMessage: .contact, contentUser: contact), isRecipient: true, date: Date()))
                                        contactsShare.toggle()
                                    } label: {
                                        LabelUserView(user: contact)
                                    }
                                   
                                }
                            }
                        }
                    }
                }
            }
        }
        .onDisappear {
            conversation.readAllMessages()
        }
    }
    
}

/*struct MessagesView_Previews: PreviewProvider {
 static var previews: some View {
 MessagesView()
 }
 }*/
