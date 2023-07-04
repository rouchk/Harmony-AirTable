//
//  MessageView.swift
//  Harmony
//
//  Created by apprenant49 on 23/06/2023.
//

import SwiftUI

struct LabelMessageView: View {
    @ObservedObject var user : User
    @ObservedObject var message : MessageContent
    var date : String?
    var iconDestinataire : String?
    @State var actionNewConversationView = false
    @State var actionEventView = false
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {

                if (iconDestinataire == nil) {
                    Spacer()
                }
                
                HStack(alignment: .top) {
                    VStack(alignment: .trailing) {
                        switch message.typeMessage {
                        case .text:
                            Text(message.contentText!)
                                .padding(15)
                                .frame(width: 250, alignment: .leading)
                                .background((iconDestinataire != nil) ? Color.darkPeriwinkle : Color.sky)
                                .foregroundColor((iconDestinataire != nil) ? Color.white : Color.black)
                                .cornerRadius(10)
                                .modifier(NormalWhite())
                            
                        case .contact:
                            Button {
                                // add user in myContact if he don't exist in list
                                if (!user.isMyContacts(user: message.contentUser!)) {
                                    user.addMyContacts(user: message.contentUser!)
                                }
                                
                                // new conversation in array conversation
                                user.newConversation(user: message.contentUser!, isRead: true)
                                
                                actionNewConversationView = true
                            } label: {
                                
                                VStack(alignment: .trailing) {
                                    Text("Contact")
                                        .padding(0)
                                        .font(.system(size:12))
                                        .modifier(Italic())
                                        .foregroundColor(Color.white)
                                    
                                    LabelUserView(user: message.contentUser!)
                                        .padding(5)
                                        .frame(width: 200, alignment: .leading)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                                .padding(15)
                                .frame(width: 250, alignment: .center)
                                .background((iconDestinataire != nil) ? Color.darkPeriwinkle : Color.sky)
                                .foregroundColor((iconDestinataire != nil) ? Color.white : Color.black)
                                .cornerRadius(10)
                                .modifier(NormalWhite())
                            }
                            
                        case .event:
                            Button {
                                actionEventView = true
                            } label: {
                                VStack(alignment: .trailing) {
                                    Text("Evenement")
                                        .padding(0)
                                        .font(.system(size:12))
                                        .modifier(Italic())
                                        .foregroundColor(Color.white)
                                    
                                    EventListRowView(myEvent: message.contentEvent!, isSmall: true)
                                        .padding(5)
                                        .frame(width: 200, alignment: .leading)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                }
                                .padding(15)
                                .frame(width: 250, alignment: .center)
                                .background((iconDestinataire != nil) ? Color.darkPeriwinkle : Color.sky)
                                .foregroundColor((iconDestinataire != nil) ? Color.white : Color.black)
                                .cornerRadius(10)
                                .modifier(NormalWhite())
                            }
                           
                        }
                        
                        if (date != nil) {
                            HStack() {
                                Text(date!)
                                    .padding(.trailing, 10)
                                    .modifier(SmallGray())
                            }
                        }
                    }
                    .padding((iconDestinataire != nil) ? .leading : .trailing, 15)
                }
                
                if (iconDestinataire != nil) {
                    Spacer()
                }
            }
            
        }
        .sheet(isPresented: $actionNewConversationView) {
            NewConversationView(users: users, user: user, isAction: $actionNewConversationView)
        }
        
        .sheet(isPresented: $actionEventView) {
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        actionEventView.toggle()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.largeTitle)
                    }
                    .padding(10)
                }
                DetailEventView(event: message.contentEvent!)
            }
            
        }
    }
}
//
//struct LabelMessageView_Previews: PreviewProvider {
//    static var previews: some View {
//        LabelMessageView(message: "Salut, est-ce que tu vas participer à l’évènement de demain?", date: "12h25")
//    }
//}
