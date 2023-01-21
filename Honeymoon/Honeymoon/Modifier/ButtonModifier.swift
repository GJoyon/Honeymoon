//
//  ButtonModifier.swift
//  Honeymoon
//
//  Created by Sua Lee on 1/5/23.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .background(
                Capsule().fill(Color.pink)
            )
    }
}
