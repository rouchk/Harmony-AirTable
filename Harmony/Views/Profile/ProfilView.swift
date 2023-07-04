//
//  ProfilView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct ProfilView: View {
    
    @ObservedObject var currentUser : User
    
    @State private var isEditingProfile = false // Add a state for controlling the navigation
    
    func myCommunities(myUser: User) -> [Community] {
        return arrayOfCulture.filter { $0.members.contains(myUser)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                
                ZStack(alignment: .top) {
                    Image(currentUser.coverPhoto)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                    Circle()
                        .stroke(Color.whiteSmoke, lineWidth: 16)
                        .frame(width: 120, height: 120)
                        .padding(.top, 140)
                    Image(currentUser.photo)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .padding(.top, 140)
                }
                .padding(.bottom, 8)
                
                
                VStack(spacing: 8) {
                    Text(currentUser.pseudo)
                        .modifier(Head0())
                    
                    HStack {
                        MapPinView()
                        Text(currentUser.city)
                        
                    }
                    .modifier(HeadGray())
                }
                .padding(.bottom, 24)
                
                HStack(spacing: 16) {
                    NavigationLink(destination: ProfileCustomView(currentUser: currentUser), isActive: $isEditingProfile) {
                        EmptyView()
                    }
                    .hidden()
                    
                    Button {
                        isEditingProfile = true // Activate the navigation
                    } label: {
                        Image(systemName: "square.and.pencil")
                        Text("Modifier le Profil")
                            .padding(4)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.graySky.opacity(0.4))
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
                
                // Title "À propos de moi"
                VStack(alignment: .leading, spacing: 16) {
                    Text("À propos de moi")
                        .modifier(Head1())
                    
                    Text(currentUser.about)
                        .modifier(Normal())
                }
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 24))
                
                
                // Title "Mes langues"
                VStack(alignment: .leading, spacing: 16) {
                    Text("Mes langues")
                        .modifier(Head1())
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(currentUser.language, id: \.self) { language in
                                Text(language.rawValue)
                                    .padding(8)
                                    .background(Color.darkPeriwinkle)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 24))
                
                
                // Title "Mes Communautés"
                VStack(alignment: .leading, spacing: 16) {
                    Text("Mes Communautés")
                        .modifier(Head1())
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(myCommunities(myUser: currentUser)) { community in
                                
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
                                        //                                            .padding(.bottom, 4)
                                        //                                            .border(.red)
                                        
                                    }
                                    .frame(width: 136, height: 160)
                                    //                                    .border(.red)
                                    
                                }
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 0))
                
                
                // Titre : Mon prochaine événement
                VStack(alignment: .leading, spacing: 16) {
                    Text("Mon prochaine événement")
                        .modifier(Head1())
                    
                    EventListRowView(myEvent: eventMarie)
                        .cornerRadius(8)
                }
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 8, trailing: 24))
                
                
                // Titre : Mon prochaine événement
                VStack(alignment: .leading, spacing: 16) {
                    Text("Media")
                        .modifier(Head1())
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 16) {
                            ForEach(currentUser.media, id: \.self) { media in
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
                    
                    

                    //                Make a list to display all the languages of the user with Text(userViewModel.currentUser.language)
                    
//                    Spacer() // Add space at the bottom
//                }
            }
        }
    }
}

struct ProfilView_Previews: PreviewProvider {
    static var previews: some View {
        //let userViewModel = UserViewModel(currentUser: myUser)
        
        ProfilView(currentUser: myUser)
        //.environmentObject(userViewModel) // Provide the UserViewModel as an environment object
    }
}
