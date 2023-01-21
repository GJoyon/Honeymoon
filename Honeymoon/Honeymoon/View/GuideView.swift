//
//  GuideView.swift
//  Honeymoon
//
//  Created by Sua Lee on 1/4/23.
//

import SwiftUI

struct GuideView: View {
    // MARK: - PROPERTIES
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: - BODY
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()
                
                Spacer(minLength: 10)
                
                Text("Get Started!")
                    .fontWeight(.black)
                    .modifier(TitleModifier())
                
                Text("""
                    Discover and pick the perfect destination \
                    for your romantic honeymoon!
                    """)
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                
                Spacer(minLength: 10)
                
                VStack(alignment: .leading, spacing: 24) {
                    GuideComponent(title: "Like",
                                   subtitle: "Swipe right",
                                   description: """
                                                Do you like this destination? \
                                                Touch the screen and swipe right. \
                                                It will be saved to the favorites.
                                                """,
                                   icon: "heart.circle")
                    
                    GuideComponent(title: "Dismiss",
                                   subtitle: "Swipe left",
                                   description: """
                                                Would you rather skip this place? \
                                                Touch the screen and swipe left. \
                                                You will no longer see it.
                                                """,
                                   icon: "xmark.circle")
                    
                    GuideComponent(title: "Book",
                                   subtitle: "Tap the button",
                                   description: """
                                                Our selection of honeymoon resorts \
                                                is perfect setting for you to \
                                                embark your new life together.
                                                """,
                                   icon: "checkmark.square")
                } //: Inner guide V-Stack
                
                Spacer(minLength: 10)
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("continue".uppercased())
                        .modifier(ButtonModifier())
                } //: Button
            } //: Outer V-Stack
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 14)
            .padding([.bottom, .horizontal], 24)
        } //: Scroll view
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView()
    }
}
