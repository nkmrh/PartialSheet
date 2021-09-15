//
//  View+PartialSheetModifier.swift
//  PartialModal
//
//  Created by Miotto Andrea on 10/11/2019.
//  Copyright © 2019 Miotto Andrea. All rights reserved.
//

import SwiftUI

@available(iOSApplicationExtension, unavailable)
extension View {
    /**
     Add a PartialSheet to the current view. You should attach it to your Root View.
     Use the **PartialSheetManager as an environment object** to present it whenever you want, or simply use the **func partialSheet** from any view in the hierarchy.
     - parameter style: The style configuration for the Partial Sheet.
     */
    public func attachPartialSheetToRoot() -> some View {
        modifier(PartialSheet())
    }
    /**
     Presents the **PartialSheet** attached to the root of the hierarchy.
     - parameter isPresented: Shows and hide the Partial Sheet.
     - parameter style: The new Partial sheet Style
     - parameter content: The content of the Partial Sheet.
     */
    public func partialSheet<Content: View>(isPresented: Binding<Bool>,
                                            style: PartialSheetStyle = .defaultStyle(),
                                            @ViewBuilder content: @escaping () -> Content) -> some View {
        PartialSheetManagerWrapper(isPresented: isPresented, content: content, style: style, parent: self)
    }
}
