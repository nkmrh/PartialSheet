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
    let content: () -> SheetContent
    let style: PartialSheetStyle
    let parent: Parent
    
    var body: some View {
        parent
            .onChange(of: isPresented, perform: {_ in updateContent() })
    }
    
    func updateContent() {
        partialSheetManager.style = style
        partialSheetManager.updatePartialSheet(isPresented: isPresented, content: content, onDismiss: {
            self.isPresented = false
        })
    }
    
}
