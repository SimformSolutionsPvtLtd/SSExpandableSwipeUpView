//
//  FontModifier.swift
//
//
//  Created by Purva Rupareliya on 05/02/24.
//

import Foundation
import SwiftUI

struct FontModifier: ViewModifier {
    var name: String?
    var size: CGFloat
    var color: Color

    func body(content: Content) -> some View {
        content
            .font(name.map { .custom($0, size: size) } ?? .system(size: size))
            .foregroundStyle(color)
    }
}

extension View {
    func customFont(name: String?, size: CGFloat, color: Color) -> some View {
        self.modifier(FontModifier(name: name, size: size, color: color))
    }
}
