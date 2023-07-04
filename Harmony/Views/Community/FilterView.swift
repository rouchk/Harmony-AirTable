import SwiftUI

struct FilterView: View {
    @Binding var showSheet: Bool
    @Binding var isOptionsActivited: [Continent : Bool]
    @Binding var isAllOptionsActivited: Bool
    @Binding var isMyCommunities: Bool
    @State var isOneOptionActivited: Bool = false
    
    private func binding(for key: Continent) -> Binding<Bool> {
            return .init(
                get: { self.isOptionsActivited[key, default: false] },
                set: { self.isOptionsActivited[key] = $0 })
    }
    
    private func allContinentsActivited() {
        for continent in Continent.allCases {
            if isOptionsActivited[continent] != nil {
                isOptionsActivited[continent]!.toggle()
            } else {
                isOptionsActivited[continent] = true
            }
        }
    }
    
    private func isOneContinentIsActivited() -> Bool {
        var i = false
        
        for (cont, isCont) in isOptionsActivited {
            if isCont {
                i = true
                break
            }
        }
        return i
    }
   
    var body: some View {
        NavigationView{
            
            Form {
                VStack {
                    
                    List {
                        Section(header: Text("Continents")) {
                            
                            ForEach(Continent.allCases, id: \.self) { continent in
                                Toggle(isOn: self.binding(for: continent), label: {
                                    Text(continent.rawValue)
                                    .font(.custom("Urbanist", size: 20))})
                                .toggleStyle(SwitchToggleStyle(tint: Color.darkPeriwinkle))
                                .disabled(isMyCommunities)
                            }
                            Toggle(isOn: $isAllOptionsActivited, label: {
                                Text("Tous les continents")
                                .font(.custom("Urbanist", size: 20))})
                            .toggleStyle(SwitchToggleStyle(tint: Color.darkPeriwinkle))
                            .disabled(isMyCommunities)
                        }
                        
                        Section(header: Text("Autre")) {
                            Toggle(isOn: $isMyCommunities, label: {
                                Text("Mes communautés")
                                .font(.custom("Urbanist", size: 20))})
                            .toggleStyle(SwitchToggleStyle(tint: Color.darkPeriwinkle))
                            .disabled(isAllOptionsActivited || isOneContinentIsActivited())
                            
                        }
                        
                        
                        Button {
                            showSheet.toggle()
                        } label: {
                            Text("Appliquer les filtres")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.darkPeriwinkle)
                                .cornerRadius(10)
                            
                        }
                        .padding(.vertical,16)
                    }
                }
                .padding(.top,16)
                
            }
            .onChange(of:isAllOptionsActivited) { newValue in
                allContinentsActivited()
            }
            .navigationTitle("Catégorie")
            .modifier(Normal())
        }
    }
}
