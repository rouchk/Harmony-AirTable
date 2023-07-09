//
//  MenuView.swift
//  Harmony
//
//  Created by apprenant49 on 22/06/2023.
//

import SwiftUI

struct MenuView: View {
    
    
    @ObservedObject var usersVM : UsersVM
    @ObservedObject var eventsVM : EventsViewModel
    @ObservedObject var newsmodel : Post
    @ObservedObject var communitiesVM : CommunitiesVM
    
//    init() {
//        
////        self.usersVM = usersVM
////        self.eventsVM = eventsVM
////        self.newsmodel = newsmodel
////        
//        UITabBar.appearance().backgroundColor = UIColor(Color.white)
//        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("GraySky"))
//       
//      }
    
    var body: some View {
        ZStack {
            TabView {
                NewsView(usersVM: usersVM, newsmodel: newsmodel, eventsVM: eventsVM, communitiesVM: communitiesVM)
                    .tabItem {
                    Image(systemName: "house")
                            .environment(\.symbolVariants, .none)
                    Text("Actualités")
                }
                
                EventsView(usersVM: usersVM, eventsList: eventsVM, communitiesVM: communitiesVM)
                    .tabItem {
                    Image(systemName: "calendar")
                    Text("Evénements")
                }
                
                ExploreView(usersVM: usersVM, communitiesVM: communitiesVM, eventsVM: eventsVM)
                    .tabItem {
                    Image(systemName: "globe")
                    Text("Explorer")
                }
                
                ChatView(users: usersVM, eventsVM: eventsVM, communitiesVM: communitiesVM)
                    .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                            .environment(\.symbolVariants, .none)
                    Text("Messages")
                }
                
                ProfilView(usersVM: usersVM, eventsVM: eventsVM, communitiesVM: communitiesVM)
                    .tabItem {
                    Image(systemName: "person")
                            .environment(\.symbolVariants, .none)
                    Text("Profil")
                }
            }
            .accentColor(Color("Sapphire"))
        }
    }
}
//
//struct MenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        MenuView()
//    }
//}
