//
//  SymbolModifier.swift
//  Honeymoon
//
//  Created by Sua Lee on 1/7/23.
//

import SwiftUI

struct SymbolModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 128))
            .foregroundColor(.white)
            .shadow(color: .black.opacity(0.2), radius: 12)
    }
}
