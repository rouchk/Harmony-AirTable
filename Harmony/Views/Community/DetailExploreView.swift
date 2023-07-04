//
//  DetailExploreView.swift
//  Harmony
//
//  Created by apprenant60 on 23/06/2023.
//

import SwiftUI

struct DetailExploreView: View {
    
    var community : Community
    
    var body: some View {
        
        
        ZStack(alignment: .top){
            
            Rectangle()
                .fill(.white)
                .frame(height: 296)
            
            VStack {
                Image(community.photo)
                    .resizable()
                    .frame(width: 342, height: 200)
                    .scaledToFill()
                
                HStack(alignment: .center) {
                    Image(community.photo1)
                        .resizable()
                        .frame(width: 72, height: 72)
                        .cornerRadius(8)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(community.name)
                            .modifier(Head1())
                        
                        HStack(spacing: 1) {
                            Image(systemName: "star.fill")
                                .foregroundColor(Color.saharaSand)
                            Text(String(community.rating))
                                .modifier(Head2())
                        }
                    }
                    .padding(.leading, 20)
                }
                .frame(width: 342, height: 80, alignment: .leading)
                .padding(.leading, 32)
//                           .border(.blue)
            }
        }
        .frame(width: 342, height: 296)
        .cornerRadius(8)
//                    .border(.red)
        
        
        
        
    }
}

struct DetailExploreView_Previews: PreviewProvider {
    static var previews: some View {
        
        DetailExploreView(community: culturefrancaises)
    }
}
