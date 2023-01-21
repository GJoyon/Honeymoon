//
//  HeaderView.swift
//  Honeymoon
//
//  Created by Sua Lee on 1/3/23.
//

import SwiftUI

struct HeaderView: View {
    // MARK: - PROPERTIES
    @Binding var showingGuideView: Bool
    @Binding var showingInfoView: Bool
    
    let haptics = UINotificationFeedbackGenerator()
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Button {
                SoundPlayer.shared.playSound(sound: "sound-click", type: "mp3")
                haptics.notificationOccurred(.success)
                
                showingInfoView = true
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.primary)
            }
            .sheet(isPresented: $showingInfoView) {
                InfoView()
            }
            
            Spacer()
            
            Image("logo-honeymoon-pink")
                .resizable()
                .scaledToFit()
                .frame(height: 28)
            
            Spacer()
            
            Button {
                SoundPlayer.shared.playSound(sound: "sound-click", type: "mp3")
                haptics.notificationOccurred(.success)
                
                showingGuideView = true
            } label: {
                Image(systemName: "questionmark.circle")
                    .font(.system(size: 24, weight: .regular))
                    .foregroundColor(.primary)
            }
            .sheet(isPresented: $showingGuideView) {
                GuideView()
            }
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    @State static var showGuide = false
    @State static var showInfo = false
    
    static var previews: some View {
        HeaderView(showingGuideView: $showGuide, showingInfoView: $showInfo)
            .previewLayout(.fixed(width: 375, height: 80))
    }
}
