//
//  NewsView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct NewsView: View {
    
    @ObservedObject var newsmodel: Post
    
    var body: some View {
        NavigationView(){
            ScrollView{
                LazyVStack(spacing: 10) {
                    ForEach(newsmodel.newsmodel) { update in
                        NavigationLink(destination: DetailNewsView(news: update, community: culturehawaienne, eventsList: EventsViewModel())) {

                            NewsViewModel(news: update)
                        }
                    }
                }
                
                // fin lazyVstack
            }//fin scrollview
            .navigationBarTitle("Actualités", displayMode: .inline )
        }// fin navigationView
    }//fin body
}//fin newsview

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView(newsmodel: Post())
    }
}






