//
//  ExploreView.swift
//  Harmony
//
//  Created by apprenant44 on 21/06/2023.
//

import SwiftUI

struct ExploreView: View {
    
    @ObservedObject var currentUser: User
    @State var textToSearch = ""
    @State var isContinentsActivited: [Continent : Bool] = [:]
    @State var isAllContinentsActivited: Bool = false
    @State var isMyCommunities: Bool = false
    
    private func isOneContinentIsActivited() -> Bool {
        var i = false
        
        for (cont, isCont) in isContinentsActivited {
            if isCont {
                i = true
                break
            }
        }
        return i
    }
    
    @State var showSheet = false
    
    
    init(currentUser: User) {
        self.currentUser = currentUser
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(Color.whiteSmoke.opacity(0.1))
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(.midnight)
    }
    
    
    var body: some View {
        
        NavigationStack {
            //            ScrollView {
            VStack {
                
                //                TextField("Rechercher une communauté",
                //                          text: $searchCommunity)
                //                    .textFieldStyle(.roundedBorder)
                //                    .frame(width: 342, height: 44)
                //                    .padding(.bottom, 8)
                
                HStack {
                    Button {
                        showSheet.toggle()
                    } label: {
                        HStack {
                            Image(systemName:"slider.horizontal.3")
                            Text(" Filtrer les categories")
                        }
                        .font(.custom("Urbanist", size: 18))
                        .frame(width: 316, height: 44)
                    }
                    .foregroundColor(.white)
                    .background(Color.darkPeriwinkle)
                    .cornerRadius(10)
                }
                
                
                List {
                    ForEach(serchCommunity) { culture in
                        ZStack {
                            NavigationLink {
                                DetailCommunityView(community: culture, eventsList: EventsViewModel())
                            } label: {
                                EmptyView()
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            DetailExploreView(community: culture)
                        }
                        .listRowBackground(
                            Rectangle()
                                .fill(.white)
                                .padding(16))
                        .frame(width: 342)
                        .cornerRadius(8)
                        .listRowSeparator(.hidden)
                    }
                } // end List
                .scrollContentBackground(.hidden)
                .background(Color.whiteSmoke)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
            }
            .navigationBarTitle("Explorer", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .background(Color.whiteSmoke)
            .searchable(text: $textToSearch, prompt: "Pays, nom...")
        }
        
        .sheet(isPresented: $showSheet){
            FilterView(showSheet: $showSheet, isOptionsActivited: $isContinentsActivited, isAllOptionsActivited: $isAllContinentsActivited, isMyCommunities: $isMyCommunities)
        }
    }
    
    var serchCommunity: [Community] {
        var array1 : [Community] = []
        let array2 = arrayOfCulture
        
        if (isMyCommunities) {
            array1 = array2.filter { $0.members.contains(currentUser)}
        } else {
            if (isContinentsActivited != [:]) && isOneContinentIsActivited() {
                for (cont, isCont) in isContinentsActivited {
                    if isCont {
                        array1 += array2.filter { $0.continent == cont }
                    }
                }
            } else {
                array1 = array2
            }
        }
       
        
        if textToSearch.isEmpty {
            return array1
        } else {
            return array1.filter { $0.name.contains(textToSearch)
            }
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(currentUser: myUser)
    }
}
