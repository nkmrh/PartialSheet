//
//  PartialSheetManager.swift
//  PartialSheetExample
//
//  Created by Andrea Miotto on 29/4/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import Combine
import SwiftUI
/**
 The Partial Sheet Manager helps to handle the Partial Sheet when you have many view layers.
 
 Make sure to pass an instance of this manager as an **environmentObject** to your root view in your Scene Delegate:
 ```
 let sheetManager: PartialSheetManager = PartialSheetManager()
 let window = UIWindow(windowScene: windowScene)
 window.rootViewController = UIHostingController(
 rootView: contentView.environmentObject(sheetManager)
 )
 ```
 */
public class PartialSheetManager: ObservableObject {
    
    /// Published var to present or hide the partial sheet
    @Published var isPresented: Bool = false {
        didSet {
            if !isPresented {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
                    self?.content = EmptyView().eraseToAnyView()
                    self?.onDismiss = nil
                }
            }
        }
    }
    /// The content of the sheet
    @Published private(set) var content: AnyView
    
    /// the onDismiss code runned when the partial sheet is closed
    private(set) var onDismiss: (() -> Void)?
    
    /// The default slide in/out animation of the partial sheet
    private var defaultSlideAnimation: Animation = {
        .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0)
    }()
    
    /**
     Modify this property to change the slide in/out animation.
     You can restore the default one calling **restoreDefaultSlideAnimation**
     **/
    public var slideAnimation: Animation?
    
    /// The Partial Sheet Style configuration
    var style: PartialSheetStyle = .defaultStyle()
    
    public init() {
        content = EmptyView().eraseToAnyView()
        slideAnimation = defaultSlideAnimation
    }
    
    /**
     Updates some properties of the **Partial Sheet**
     - parameter isPresented: If the partial sheet is presented
     - parameter content: The content to place inside of the Partial Sheet.
     - parameter onDismiss: This code will be runned when the sheet is dismissed.
     */
    func updatePartialSheet<T>(isPresented: Bool? = nil,
                               style: PartialSheetStyle? = nil,
                               content: (() -> T)? = nil,
                               onDismiss: (() -> Void)? = nil) where T: View {
        if let content = content {
            self.content = AnyView(content())
        }
        if let style = style {
            self.style = style
        }
        if let onDismiss = onDismiss {
            self.onDismiss = onDismiss
        }
        if let isPresented = isPresented {
            withAnimation(slideAnimation) {
                self.isPresented = isPresented
            }
        }
    }
    
    /// Restore the default slide in/out animation
    func restoreDefaultSlideAnimation() {
        slideAnimation = defaultSlideAnimation
    }
}
