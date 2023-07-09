//
//  DetailCommunityView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI


struct DetailCommunityView: View {
    
    //    @EnvironmentObject var teamVM: teamView
    //    @ObservedObject var users = UsersVM()
    
    @ObservedObject var community : Community
    
    @State var showConfirmation: Bool = false
    @State var showAlert: Bool = false
    
    @ObservedObject var eventsList: EventsViewModel
    @ObservedObject var communitiesVM: CommunitiesVM
    @ObservedObject var usersVM: UsersVM
    
    @State var showSheet = false
    
    var body: some View {
        
        ScrollView {
            VStack {
                Image(community.photo)
                    .resizable()
                    .scaledToFit()
                
                HStack(alignment: .center){
                    Image(community.photo1)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 75, height: 75)
                        .cornerRadius(8)
                        .padding(.leading, 32)
                                        
                    VStack(alignment: .leading, spacing: 4) {
                        Text(community.name)
                            .modifier(Head0())
                        HStack(spacing: 1) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.saharaSand)
                            Text(String(community.rating))
                            Spacer()
                        }
                        
                    }
                    .padding(EdgeInsets(top: 8, leading: 32, bottom: 8, trailing: 24))
                }
                .padding(.vertical, 16)

                
                
                if (self.community.members.contains(usersVM.myUser!)) {
                    DeactivatedButonView()
                    // If the user is already member of this community
                } else {
                    // If the user is not member yet
                    Button {
                        showConfirmation = true
                    } label: {
                        Text("Rejoindre la communauté")
                            .frame(width: 316, height: 44)
                            .foregroundColor(.white)
                            .font(.custom("UrbanistMedium", size: 18))
//                            .fontWeight(.bold)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.darkPeriwinkle)
                    .cornerRadius(8)
                    .padding(.vertical, 16)
                    
                    .alert("Félicitations !", isPresented: $showConfirmation) {
                                Button("OK") {
                                    self.community.members.append(myUser)
                                    showConfirmation = false
                                }
                            } message: {
                                Text("Vous avez rejoint la communauté \(self.community.name).")
                            }
                }
                

                
                VStack(spacing: 32) {
                    
                    VStack(alignment: .leading) {
                        Text("Hôtes")
                            .modifier(Head1())
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(community.hosts) { host in
                                    NavigationLink {
                                        OtherUserProfileView(user: host, usersVM: usersVM, eventsList: eventsList, communitiesVM: communitiesVM)
                                    } label: {
                                        IconUserView(icon: host.photo, isConnected: host.isConnected)
                                        //Text(host.pseudo)
                                    }
                                }
                            }
                            .frame(height: 52)
                        }
                    }
                    .padding(.leading, 24)

                    
                                        
                    VStack(alignment: .leading) {
                        Text("Membre de la communauté")
                            .modifier(Head1())
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(community.members) { member in
                                    NavigationLink {
                                        OtherUserProfileView(user: member, usersVM: usersVM, eventsList: eventsList, communitiesVM: communitiesVM)
                                    } label: {
                                        IconUserView(icon: member.photo, isConnected: member.isConnected)
                                    }
                                }
                            }
                            .frame(height: 52)
                        }
                    }
                    .padding(.leading, 24)
                    
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .modifier(Head1())
                        Text(community.description)
                            .modifier(Normal())
                    }
                    .padding(.horizontal, 24)
                    

                    
                    VStack(alignment: .leading) {
                        Text("Evénement a venir")
                            .modifier(Head1())
                            .padding(.bottom, 8)
                        
                        ForEach(eventFilter) { event in
                            NavigationLink {
                                DetailEventView(event: event, eventsVM: eventsList, usersVM: usersVM, communitiesVM: communitiesVM)
                            } label: {
                                EventListRowView(myEvent: event)
                            }
                            .cornerRadius(8)
                        }
                        .padding(.vertical, 4)
                        
//                        if (self.community.members.contains(myProfil)) {
//                            ForEach(eventFilter) { event in
//                                NavigationLink {
//                                    DetailEventView(event: event)
//                                } label: {
//                                    EventListRowView(myEvent: event)
//                                }
//                                .cornerRadius(8)
//                            }
//                        } else {
//                            ForEach(eventFilter) { event in
//                                Button {
//                                    showAlert = true
//                                } label: {
//                                    EventListRowView(myEvent: event)
//                                }
//                                .cornerRadius(8)
//                                .alert("Vous n'êtes pas encore le membre de \(self.community.name).", isPresented: $showAlert) {
//                                    Button("OK", role: .cancel) {}
//                                } message: {
//                                    Text("Pour accéder à l'evenement, rejoinez d'abord à la communauté.")
//                                }
//                            }
//                        }
                    }
//                    .padding(.horizontal, 24)
                    .padding(EdgeInsets(top: 0, leading: 24, bottom: 16, trailing: 24))
                    
                    if (self.community.members.contains(usersVM.myUser!)) {
                                NavigationLink {
                                    CreateEvenementView(usersVM: usersVM, communitiesVM: communitiesVM, eventsVM: eventsList)
                                } label: {
                                    Text("Proposer un événement")
                                        .frame(width: 316, height: 44)
                                        .background(Color.darkPeriwinkle)
                                        .cornerRadius(8)
                                    .foregroundColor(Color.white)
                                    .font(.custom("Urbanist", size: 20))
                                }
                            .padding(.horizontal, 24)
                                
                        }
                }
            } // end of the biggest VStack
            .background(Color.whiteSmoke)
            
//            .sheet(isPresented: $showSheet){
//                CreateEvenementView()
//            }
            
        }
        .onAppear {
            community.hosts = community.hosts.map {
                var mutableHost = $0
                if !mutableHost.isFetch {
                    let id = mutableHost.idAPI
                    let u = usersVM.getUserById(id: id)
                    if u == nil {
                        Task {
                            await mutableHost = usersVM.getUserByIdInAirtable(id: id)!
                        }
                    } else {
                        mutableHost = u!
                    }
                }
                return mutableHost
            }
            
            community.members = community.members.map {
                var mutableMember = $0
                if !mutableMember.isFetch {
                    let id = mutableMember.idAPI
                    let u = usersVM.getUserById(id: id)
                    if u == nil {
                        Task {
                            await mutableMember = usersVM.getUserByIdInAirtable(id: id)!
                        }
                    } else {
                        mutableMember = u!
                    }
                }
                return mutableMember
            }
            
            community.events = community.events.map {
                var mutableEvent = $0
                if !mutableEvent.isFetch {
                    let id = mutableEvent.idAPI
                    let u = eventsList.getEventById(id: id)
                    if u == nil {
                        Task {
                            await mutableEvent = eventsList.getEventByIdInAirtable(id: id)!
                        }
                    } else {
                        mutableEvent = u!
                    }
                }
                return mutableEvent
            }
        }
    }
    
    
    var eventFilter: [Event] {
        return eventsList.eventsList.filter { event in
            (community.idAPI == event.community?.idAPI) && (event.date! > Date())
        }.sorted(by: { $0.date! < $1.date! })
    }
}
//
//struct DetailCommunityView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailCommunityView(community: culturefrancaises, eventsList: EventsViewModel())
//    }
//}



// -------------- Extracted View ------------------

struct DeactivatedButonView: View {
    var body: some View {
        Button {
            //
        }label: {
            HStack {
                Image(systemName:"checkmark")
                Text("Déjà membre")
            }
            .frame(width: 316, height: 44)
            .modifier(Head2())
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.sky.opacity(0.5))
        .padding(.vertical, 16)
    }
}
