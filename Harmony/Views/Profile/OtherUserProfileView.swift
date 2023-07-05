//
//  OtherUserProfileView.swift
//  Harmony
//
//  Created by apprenant71 on 04/07/2023.
//

import SwiftUI

struct OtherUserProfileView: View {
    @ObservedObject var user : User
    @ObservedObject var eventsList : EventsViewModel
    let now = Date()
    
    @State private var isEditingProfile = false // Add a state for controlling the navigation
    
    func myCommunities(user: User) -> [Community] {
        return arrayOfCulture.filter { $0.members.contains(user)
        }
    }
    
    func myNextEvent(user: User) -> Event {
        let myFuturEvents = eventsList.eventsList.filter { event in
            (event.listParticipant.contains(user)) && (event.date >= now)
        }.sorted(by: { $0.date < $1.date })
        return myFuturEvents[0]
    }
    
    
    var body: some View {

            ScrollView {
                VStack {
                    
                    ZStack(alignment: .top) {
                        Image(user.coverPhoto)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                            .clipped()
                        Circle()
                            .stroke(Color.whiteSmoke, lineWidth: 16)
                            .frame(width: 120, height: 120)
                            .padding(.top, 140)
                        Image(user.photo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .padding(.top, 140)
                    }
                    .padding(.bottom, 8)
                    
                    
                    VStack(spacing: 8) {
                        Text(user.pseudo)
                            .modifier(Head0())
                        
                        HStack {
                            MapPinView()
                            Text(user.city)
                            
                        }
                        .modifier(HeadGray())
                    }
                    .padding(.bottom, 24)
                    
                    
                    // --------------- Section : A propos de moi ---------------
                    VStack(alignment: .leading, spacing: 16) {
                        Text("À propos de moi")
                            .modifier(Head1())
                        
                        Text(user.about)
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
                                ForEach(user.language, id: \.self) { language in
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
                                ForEach(myCommunities(user: user)) { community in
                                    
                                    NavigationLink {
                                        DetailCommunityView(community: community, eventsList: EventsViewModel())
                                    } label: {
                                        ZStack(alignment: .top) {
                                            Rectangle()
                                                .fill(.white)
                                            
                                            VStack {
                                                Image(community.photo)
                                                    .resizable()
                                                    .frame(width: 136, height: 96)
                                                    .scaledToFill()

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
                            DetailEventView(event: myNextEvent(user: user))
                        } label: {
                            EventListRowView(myEvent: myNextEvent(user: user))
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
                                ForEach(user.media, id: \.self) { media in
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
    }


struct OtherUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherUserProfileView(user: userJeanChristophe, eventsList: EventsViewModel())
    }
}
