//
//  PartialSheetManagerWrapper.swift
//  PartialSheetManagerWrapper
//
//  Created by Andrea Miotto on 15/09/21.
//  Copyright © 2021 Swift. All rights reserved.
//

import Foundation
import SwiftUI

struct PartialSheetManagerWrapper<Parent: View, SheetContent: View>: View {
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    
    @Binding var isPresented: Bool
    let style: PartialSheetStyle
    let slideAnimation: Animation?
    let content: () -> SheetContent
    let parent: Parent
    
    var body: some View {
        parent
            .onChange(of: isPresented, perform: {_ in updateContent() })
    }
    
    func updateContent() {
        partialSheetManager.updatePartialSheet(isPresented: isPresented, style: style,
                                               slideAnimation: slideAnimation, content: content, onDismiss: {
            self.isPresented = false
        })
    }
    
}
