//
//  TitleModifier.swift
//  Honeymoon
//
//  Created by Sua Lee on 1/5/23.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.pink)
    }
}
