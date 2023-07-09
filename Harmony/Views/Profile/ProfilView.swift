//
//  ProfilView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct ProfilView: View {
    
//    @EnvironmentObject var dataVM: DataVM
//    @EnvironmentObject var usersVM: UsersVM
//    @EnvironmentObject var eventsVM: EventsViewModel
//
    @ObservedObject var usersVM: UsersVM
    @ObservedObject var eventsVM : EventsViewModel
    @ObservedObject var communitiesVM : CommunitiesVM
    
    let now = Date()
    
    @State private var isEditingProfile = false // Add a state for controlling the navigation
    
    func myCommunities(user: User) -> [Community] {
        return communitiesVM.communities.filter { $0.members.contains(user) }
        //return communitiesVM.communities
    }
    
    func myNextEvent(user: User) -> Event? {
//        let myFuturEvents = eventsVM.eventsList.filter { event in
//            (event.listParticipant.contains(user)) && (event.date! >= now)
//        }.sorted(by: { $0.date! < $1.date! })
//        return myFuturEvents[0]
        print(eventsVM.eventsList.count)
        return eventsVM.eventsList.first!
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    ZStack(alignment: .top) {
                        Image(usersVM.myUser!.coverPhoto)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                        Circle()
                            .stroke(Color.whiteSmoke, lineWidth: 16)
                            .frame(width: 120, height: 120)
                            .padding(.top, 140)
                        Image(usersVM.myUser!.photo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .padding(.top, 140)
                    }
                    .padding(.bottom, 8)
                    
                    
                    VStack(spacing: 8) {
                        Text(usersVM.myUser!.pseudo)
                            .modifier(Head0())
                        
                        HStack {
                            MapPinView()
                            Text(usersVM.myUser!.city)
                            
                        }
                        .modifier(HeadGray())
                    }
                    .padding(.bottom, 24)
                    
                    HStack(spacing: 16) {
                        NavigationLink(destination: ProfileCustomView(currentUser: usersVM.myUser!), isActive: $isEditingProfile) {
                            EmptyView()
                        }
                        .hidden()
                        
                        Button {
                            isEditingProfile = true // Activate the navigation
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.title3)
                            Text("Modifier le Profil")
                                .padding(4)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.graySky.opacity(0.3))
                        .cornerRadius(8)
                        .font(.custom("UrbanistSemiBold", size: 16))
                        .foregroundColor(Color.darkPeriwinkle)
                        
                        //                    NavigationLink(destination: ProfileCustomView(currentUser: currentUser), isActive: $isEditingProfile) {
                        //                        EmptyView()
                        //                    }
                        //                    .hidden()
                        
                        Image(systemName: "gearshape.fill")
                            .modifier(HeadGray())
                    }
                    .padding(.bottom, 24)
                    
                    // --------------- Section : A propos de moi ---------------
                    VStack(alignment: .leading, spacing: 16) {
                        Text("À propos de moi")
                            .modifier(Head1())
                        
                        Text(usersVM.myUser!.about)
                            .modifier(Normal())
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 24))
                    
                    
                    // ---------------  Section : Mes langues ---------------
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Mes langues")
                            .modifier(Head1())
                        //                Make a list to display all the languages of the user with Text(userViewModel.currentUser.language)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(usersVM.myUser!.language, id: \.self) { language in
                                    Text(language.rawValue)
                                        .font(.custom("UrbanistRegular", size: 16))
                                        .padding(12)
                                        .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                .stroke(lineWidth: 4)
                                            )
                                        .cornerRadius(8)
                                        .foregroundColor(Color.darkPeriwinkle)
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 24))
                    
                    
                    // --------------- Section : Mes Communautés ---------------
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Mes Communautés")
                            .modifier(Head1())
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(myCommunities(user: usersVM.myUser!)) { community in
                                    
                                    NavigationLink {
                                        DetailCommunityView(community: community, eventsList: eventsVM, communitiesVM: communitiesVM, usersVM: usersVM)
                                    } label: {
                                        ZStack(alignment: .top) {
                                            Rectangle()
                                                .fill(.white)
                                            
                                            VStack {
                                                Image(community.photo)
                                                    .resizable()
                                                    .frame(width: 136, height: 96)
                                                    .scaledToFill()
                                                //                                            .border(.red)
                                                Text(community.name)
                                                
                                                    .font(.custom("UrbanistMedium", size: 16))
                                                    .foregroundColor(Color("Sapphire"))
                                                    .frame(height: 52, alignment: .top)
                                            }
                                            .frame(width: 136, height: 160)
                                        }
                                        .cornerRadius(8)
                                    }
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 0))
                    
                    
                    // --------------- Section : Mon prochaine événement ---------------
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Mon prochain événement")
                            .modifier(Head1())
                        
                        NavigationLink {
                            DetailEventView(event: myNextEvent(user: usersVM.myUser!)!, eventsVM: eventsVM, usersVM: usersVM, communitiesVM: communitiesVM)
                        } label: {
                            EventListRowView(myEvent: myNextEvent(user: usersVM.myUser!)!)
                                .cornerRadius(8)
                        }
                    }
                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 24))
                    
                    
                    // --------------- Section : Media ---------------
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Media")
                            .modifier(Head1())
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 16) {
                                ForEach(usersVM.myUser!.media, id: \.self) { media in
                                    Image(media)
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 16, leading: 24, bottom: 36, trailing: 24))
                }
                .background(Color.whiteSmoke)
                
            }
        }
        .onAppear {
            Task {
                
                await communitiesVM.fetchCommunities()
                
                for com in communitiesVM.communitiesAPI {
                    var hosts: [User] = []
                    var members: [User] = []
                    var events: [Event] = []
                    
                    if com.hosts != nil {
                        for ho in com.hosts! {
                            var u = usersVM.getUserById(id: ho)
                            if u == nil {
                                await u = usersVM.getUserByIdInAirtable(id: ho)!
                            }
                            hosts.append(u!)
                        }
                    }
                    
                    if com.members != nil {
                        for mb in com.members! {
                            var u = usersVM.getUserById(id: mb)
                            if u == nil {
                                await u = usersVM.getUserByIdInAirtable(id: mb)!
                            }
                            members.append(u!)
                        }
                    }
                    
                    if com.events != nil {
                        for ev in com.events! {
                            events.append(eventsVM.getEventById(id: ev)!)
                        }
                    }
                    
                    communitiesVM.communities.append(Community(idAPI: com.id, name: com.name, photo: com.photo ?? "", photo1: com.photo1 ?? "", icon: com.icon ?? "", rank: com.rank ?? 0.0, description: com.description ?? "", rating: com.rating ?? 0.0, hosts: hosts, members: members, events: events, continent: APIGeneral().StringToContinent(string: com.continent!) ?? Continent.afrique))
                    
                    //await communitiesVM.communities.append(com.APItoClass())
                }
         
                
                eventsVM.refresh()
                
                await usersVM.getMyUserAirtable()
                if usersVM.myUserAPI != nil {
                    await usersVM.myUser = usersVM.myUserAPI!.APItoClass()
                } else {
                    print("CA NE MARCHE PASS")
                }
            }
        }
    }
}
//
//struct ProfilView_Previews: PreviewProvider {
//    static var previews: some View {
//        //let userViewModel = UserViewModel(currentUser: myUser)
//
//        ProfilView(currentUser: dataVM.usersVM.myUser)
//        //.environmentObject(userViewModel) // Provide the UserViewModel as an environment object
//    }
//}
