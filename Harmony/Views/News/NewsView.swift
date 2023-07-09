//
//  NewsView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct NewsView: View {
    
    @ObservedObject var usersVM: UsersVM
    @ObservedObject var newsmodel: Post
    @ObservedObject var eventsVM: EventsViewModel
    @ObservedObject var communitiesVM: CommunitiesVM
    
    var body: some View {
        NavigationView(){
            ScrollView{
                LazyVStack(spacing: 10) {
                    ForEach(newsmodel.newsmodel) { update in
                        NavigationLink(destination: DetailNewsView(usersVM: usersVM, communitiesVM: communitiesVM, eventsList: eventsVM, news: update, community: culturehawaienne)) {

                            NewsViewModel(news: update, usersVM: usersVM, eventsVM: eventsVM, communitiesVM: communitiesVM)
                        }
                    }
                }
                
                // fin lazyVstack
            }//fin scrollview
            .navigationBarTitle("Actualités", displayMode: .inline )
        }// fin navigationView
        .onAppear {
            Task {
                newsmodel.refresh()
            }
        }
    }//fin body
}//fin newsview
//
//struct NewsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewsView()
//    }
//}






