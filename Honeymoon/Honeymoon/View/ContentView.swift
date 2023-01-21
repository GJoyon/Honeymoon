//
//  ContentView.swift
//  Honeymoon
//
//  Created by Sua Lee on 1/1/23.
//

import SwiftUI

struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var showAlert = false
    @State private var showGuide = false
    @State private var showInfo = false
    @State private var lastCardIndex = 1
    @State private var cardRemovalTransition = AnyTransition.trailingBottom
    @State private var cardViews: [CardView] = {
        var views = [CardView]()
        
        for index in 0..<2 {
            views.append(CardView(honeymoon: honeymoonData[index]))
        }
        
        return views
    }()
    
    @GestureState private var dragState = DragState.inactive
    
    private let dragAreaThreshold: CGFloat = 65.0
    
    
    
    enum DragState: Equatable {
        case inactive
        case pressing
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .dragging(let translation):
                return translation
                
            default:
                return .zero
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .dragging:
                return true
                
            default:
                return false
            }
        }
        
        var isPressing: Bool {
            switch self {
            case .inactive:
                return false
                
            default:
                return true
            }
        }
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            // Header
            HeaderView(showingGuideView: $showGuide, showingInfoView: $showInfo)
                .opacity(dragState.isDragging ? 0 : 1)
                .animation(.default, value: dragState)
            
            Spacer()
            
            // Cards
            ZStack {
                ForEach(cardViews) { cardView in
                    cardView
                        .zIndex(isTopCard(cardView: cardView) ? 1 : 0)
                        .overlay(
                            ZStack {
                                // xmark symbol
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(
                                        dragState.translation.width < -dragAreaThreshold && isTopCard(cardView: cardView) ? 1 : 0
                                    )
                                
                                // heart symbol
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(
                                        dragState.translation.width > dragAreaThreshold && isTopCard(cardView: cardView) ? 1 : 0
                                    )
                            }
                        )
                        .offset(
                            x: isTopCard(cardView: cardView) ? dragState.translation.width : 0,
                            y: isTopCard(cardView: cardView) ? dragState.translation.height : 0)
                        .scaleEffect(
                            isTopCard(cardView: cardView) && dragState.isDragging ? 0.85 : 1
                        )
                        .rotationEffect(
                            Angle(degrees: isTopCard(cardView: cardView) ? Double(dragState.translation.width / 12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120,
                                                        damping: 120)
                                   , value: dragState)
                        .gesture(
                            LongPressGesture(minimumDuration: 0.01)
                                .sequenced(before: DragGesture())
                                .updating($dragState, body: { (value, state, transaction) in
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                        
                                    case .second(true, let drag):
                                        state = .dragging(
                                            translation: drag?.translation ?? .zero
                                        )
                                        
                                    default:
                                        break
                                    }
                                })
                                .onChanged({ (value) in
                                    guard case .second(true, let drag?) = value else { return }
                                    
                                    if drag.translation.width < -dragAreaThreshold {
                                        cardRemovalTransition = .leadingBottom
                                    } else if drag.translation.width > dragAreaThreshold {
                                        cardRemovalTransition = .trailingBottom
                                    }
                                })
                                .onEnded({ (value) in
                                    guard case .second(true, let drag?) = value else { return }
                                    
                                    if drag.translation.width < -dragAreaThreshold || drag.translation.width > dragAreaThreshold {
                                        SoundPlayer.shared.playSound(
                                            sound: "sound-rise",
                                            type: "mp3"
                                        )
                                        moveCards()
                                    }
                                })
                        )
                        .transition(cardRemovalTransition)
                }
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Footer
            FooterView(showBookingAlert: $showAlert)
                .opacity(dragState.isDragging ? 0 : 1)
                .animation(.default, value: dragState)
        }
        .alert("SUCCESS",
               isPresented: $showAlert,
               actions: {
                Button("Happy honeymoon!", role: .cancel, action: {})
               },
               message: {
                Text("""
                    Wishing a lovely and most precious of the times together \
                    for the amazing couple.
                    """)
               })
    }
    
    // MARK: - FUNCTIONS
    func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(
            where: { $0.id == cardView.id }
        ) else { return false }
        
        return index == 0
    }
    
    func moveCards() {
        cardViews.removeFirst()
        
        lastCardIndex = (lastCardIndex + 1) % honeymoonData.count
        let newCardView = CardView(honeymoon: honeymoonData[lastCardIndex])
        cardViews.append(newCardView)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}
