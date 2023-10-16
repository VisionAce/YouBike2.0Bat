//
//  LayoutStyle.swift
//  YouBike2.0
//
//  Created by 褚宣德 on 2023/10/15.
//

import SwiftUI


extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1,green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
    
    static var ubikeGreen: Color {
        Color(red: 0.725, green: 0.796, blue: 0.286)
    }
}

extension View {
    func buttonStyleModifier() -> some View {
        modifier(ButtonStyle())
    }
}

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .opacity(0.3)
            .padding(.vertical)
    }
}

struct  ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundStyle(.white)
    }
}
