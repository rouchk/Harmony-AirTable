//
//  test.swift
//  Harmony
//
//  Created by apprenant49 on 30/06/2023.
//

import SwiftUI

struct test: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .frame(alignment: .leading)
            }
            
            VStack(alignment: .trailing) {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            }
        }
        
    }
    
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
