//
//  CardView.swift
//  Honeymoon
//
//  Created by Sua Lee on 1/2/23.
//

import SwiftUI

struct CardView: View, Identifiable {
    // MARK: - PROPERTIES
    let id = UUID()
    
    var honeymoon: Destination
    
    // MARK: - BODY
    var body: some View {
        Image(honeymoon.image)
            .resizable()
            .scaledToFit()
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(24)
            .overlay(
                VStack(alignment: .center, spacing: 12) {
                    Text(honeymoon.place.uppercased())
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .shadow(radius: 2)
                        .padding(.horizontal, 18)
                        .padding(.bottom, 4)
                        .overlay(
                            Rectangle()
                                .fill(Color.white)
                                .frame(height: 2)
                            , alignment: .bottom
                        )
                    
                    Text(honeymoon.country.uppercased())
                        .foregroundColor(.black)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .frame(minWidth: 84)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule().fill(.white)
                        )
                } //: Overlay V-Stack
                    .frame(minWidth: 280)
                    .padding(.bottom, 50)
                , alignment: .bottom
            )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(honeymoon: honeymoonData[1])
            .previewDevice("iPhone 13 Pro")
            .previewLayout(.fixed(width: 375, height: 600))
    }
}
