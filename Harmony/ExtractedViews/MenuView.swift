//
//  MenuView.swift
//  Harmony
//
//  Created by apprenant49 on 22/06/2023.
//

import SwiftUI

struct MenuView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.white)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color("GraySky"))
      }
    
    var body: some View {
        ZStack {
            TabView {
                NewsView(newsmodel: Post())
                    .tabItem {
                    Image(systemName: "house")
                            .environment(\.symbolVariants, .none)
                    Text("Actualités")
                }
                
                EventsView()
                    .tabItem {
                    Image(systemName: "calendar")
                    Text("Evénements")
                }
                
                ExploreView(currentUser: myUser)
                    .tabItem {
                    Image(systemName: "globe")
                    Text("Explorer")
                }
                
                ChatView(user: myUser)
                    .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right")
                            .environment(\.symbolVariants, .none)
                    Text("Messages")
                }
                
                ProfilView(currentUser: myUser)
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

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
