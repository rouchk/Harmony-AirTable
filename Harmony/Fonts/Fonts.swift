//
//  Fonts.swift
//  Harmony
//
//  Created by apprenant49 on 22/06/2023.
//

import SwiftUI

struct Head0: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 28))
            .foregroundColor(Color.sapphire)
            .fontWeight(.bold)
    }
}

struct Head1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 20))
            .foregroundColor(Color("Sapphire"))
            .fontWeight(.bold)
    }
}

struct Head2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 18))
            .foregroundColor(Color("Sapphire"))
            .fontWeight(.medium)
    }
}

struct Head3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 18))
            .foregroundColor(Color("DarkPeriwinkle"))
    }
}

struct HeadGray: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 18))
            .foregroundColor(Color("DarkGray"))
            .fontWeight(.medium)
    }
}

struct MinHead1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 14))
            .foregroundColor(Color("Sapphire"))
            .fontWeight(.bold)
    }
}

struct MinHead3: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 10))
            .foregroundColor(Color("DarkPeriwinkle"))
    }
}

struct MinHeadGray: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 12))
            .foregroundColor(Color("DarkGray"))
            .fontWeight(.medium)
    }
}

struct SmallGray: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 11))
            .foregroundColor(Color("DarkGray"))
            .fontWeight(.medium)
    }
}

struct Small: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 11))
            .foregroundColor(Color("Midnight"))
            .fontWeight(.medium)
    }
}

struct Normal: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 16))
            .foregroundColor(Color("Midnight"))
    }
}

struct NormalWhite: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 16))
            .foregroundColor(.white)
    }
}

struct Italic: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Urbanist", size: 16))
            .italic()
    }
}
