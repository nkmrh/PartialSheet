//
//  PartialSheetViewModifier.swift
//  PartialModal
//
//  Created by Miotto Andrea on 09/11/2019.
//  Copyright © 2019 Miotto Andrea. All rights reserved.
//

import SwiftUI
import Combine

/// This is the modifier for the Partial Sheet
struct PartialSheet: ViewModifier {
    // MARK: - Private Properties

    @EnvironmentObject var manager: PartialSheetManager
    @Environment(\.safeAreaInsets) var safeAreaInsets

    /// The rect containing the presenter
    @State var presenterContentRect: CGRect = .zero
    
    /// The rect containing the sheet content
    @State var sheetContentRect: CGRect = .zero
    
    /// The offset for keyboard height
    @State var keyboardOffset: CGFloat = 0
    
    /// The offset for the drag gesture
    @State var dragOffset: CGFloat = 0

    /// The point for the top anchor
    var topAnchor: CGFloat {
        let topSafeArea =  safeAreaInsets.top
        let bottomSafeArea = safeAreaInsets.bottom
        
        let calculatedTop =
            presenterContentRect.height +
            topSafeArea +
            bottomSafeArea -
            sheetContentRect.height -
            handleSectionHeight
          
        guard calculatedTop < manager.style.minTopDistance else {
            return calculatedTop
        }
        
        return manager.style.minTopDistance
    }
    
    /// The he point for the bottom anchor
    var bottomAnchor: CGFloat {
        return UIScreen.main.bounds.height + 5
    }
    
    /// The height of the handle bar section
    var handleSectionHeight: CGFloat {
        switch manager.style.handleBarStyle {
            case .solid: return 30
            case .none: return 0
        }
    }
    
    /// Calculates the sheets y position
    private var sheetPosition: CGFloat {
        if self.manager.isPresented {
            // 20.0 = To make sure we dont go under statusbar on screens without safe area inset
            let topInset = safeAreaInsets.top
            let position = self.topAnchor + self.dragOffset - self.keyboardOffset
            
            if position < topInset {
                return topInset
            }
            
            return position
        } else {
            return self.bottomAnchor - self.dragOffset
        }
    }

    /// Background of sheet
    @ViewBuilder
    private var background: some View {
        switch manager.style.background {
        case .solid(let color):
            Rectangle().fill(color)
        case .blur(let effect):
            Rectangle().fill(effect)
        }
    }
    
    // MARK: - Content Builders
    
    func body(content: Content) -> some View {
        ZStack {
            content
                // if the device type is an iPhone
                .iPhone {
                    $0
                        .background(
                            GeometryReader { proxy in
                                // Add a tracking on the presenter frame
                                Color.clear.preference(
                                    key: PresenterPreferenceKey.self,
                                    value: [PreferenceData(bounds: proxy.frame(in: .global))]
                                )
                            }
                    )
                        .onAppear{
                            let notifier = NotificationCenter.default
                            let willShow = UIResponder.keyboardWillShowNotification
                            let willHide = UIResponder.keyboardWillHideNotification
                            notifier.addObserver(forName: willShow,
                                                 object: nil,
                                                 queue: .main,
                                                 using: self.keyboardShow)
                            notifier.addObserver(forName: willHide,
                                                 object: nil,
                                                 queue: .main,
                                                 using: self.keyboardHide)
                    }
                    .onDisappear {
                        let notifier = NotificationCenter.default
                        notifier.removeObserver(self)
                    }
                    .onPreferenceChange(PresenterPreferenceKey.self, perform: { (prefData) in
                        self.presenterContentRect = prefData.first?.bounds ?? .zero
                    })
            }
                // if the device type is not an iPhone,
                // display the sheet content as a normal sheet
                .iPadOrMac {
                    $0
                        .sheet(isPresented: $manager.isPresented, onDismiss: {
                            self.manager.onDismiss?()
                        }, content: {
                            self.iPadAndMacSheet()
                        })
            }
            // if the device type is an iPhone,
            // display the sheet content as a draggableSheet
            if deviceType == .iphone {
                iPhoneSheet()
                    .edgesIgnoringSafeArea(.vertical)
            }
        }
    }
}

//MARK: - Platfomr Specific Sheet Builders
extension PartialSheet {

    //MARK: - Mac and iPad Sheet Builder

    /// This is the builder for the sheet content for iPad and Mac devices only
    private func iPadAndMacSheet() -> some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.manager.isPresented = false
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(manager.style.iPadCloseButtonColor)
                        .padding(.horizontal)
                        .padding(.top)
                })
            }
            self.manager.content
            Spacer()
        }.background(self.background)
    }

    //MARK: - iPhone Sheet Builder

    /// This is the builder for the sheet content for iPhone devices only
    private func iPhoneSheet()-> some View {
        // Build the drag gesture
        let drag = dragGesture()
        
        return ZStack {

            //MARK: - iPhone Cover View

            if manager.isPresented {
                Group {
                    if manager.style.enableCover {
                        Rectangle()
                            .foregroundColor(manager.style.coverColor)
                    }
//                    if style.blurEffectStyle != nil {
//                        Rectangle()
//                            .foregroundColor(style.blurEffectStyle)
//                    }
                }
                .edgesIgnoringSafeArea(.vertical)
                .onTapGesture {
                    withAnimation(manager.slideAnimation) {
                        self.manager.isPresented = false
                        self.dismissKeyboard()
                        self.manager.onDismiss?()
                    }
                }
            }
            // The SHEET VIEW
            Group {
                VStack(spacing: 0) {
                    switch manager.style.handleBarStyle {
                    case .solid(let handleBarColor): // This is the little rounded bar (HANDLER) on top of the sheet
                        VStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: CGFloat(5.0) / 2.0)
                                .frame(width: 40, height: 5)
                                .foregroundColor(handleBarColor)
                            Spacer()
                        }
                        .frame(height: handleSectionHeight)
                    case .none: EmptyView()
                    }
                    
                    VStack {
                        // Attach the SHEET CONTENT
                        self.manager.content
                            .background(
                                GeometryReader { proxy in
                                    Color.clear.preference(key: SheetPreferenceKey.self, value: [PreferenceData(bounds: proxy.frame(in: .global))])
                                }
                        )
                    }
                    Spacer()
                }
                .onPreferenceChange(SheetPreferenceKey.self, perform: { (prefData) in
                    withAnimation(manager.slideAnimation) {
                        self.sheetContentRect = prefData.first?.bounds ?? .zero
                    }
                })
                .frame(width: UIScreen.main.bounds.width)
                .background(self.background)
                .cornerRadius(manager.style.cornerRadius)
                .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
                .offset(y: self.sheetPosition)
                .gesture(drag)
            }
        }
    }
}

// MARK: - PreferenceKeys Handles
extension PartialSheet {

    /// Preference Key for the Sheet Presener
    struct PresenterPreferenceKey: PreferenceKey {
        static func reduce(value: inout [PartialSheet.PreferenceData], nextValue: () -> [PartialSheet.PreferenceData]) {
            value.append(contentsOf: nextValue())
        }
        static var defaultValue: [PreferenceData] = []
    }

    /// Preference Key for the Sheet Content
    struct SheetPreferenceKey: PreferenceKey {
        static func reduce(value: inout [PartialSheet.PreferenceData], nextValue: () -> [PartialSheet.PreferenceData]) {
            value.append(contentsOf: nextValue())
        }
        static var defaultValue: [PreferenceData] = []
    }

    /// Data Stored in the Preferences
    struct PreferenceData: Equatable {
        let bounds: CGRect
    }

}
