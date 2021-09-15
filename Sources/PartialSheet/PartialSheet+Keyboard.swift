//
//  PartialSheet+Keyboard.swift
//  PartialSheet+Keyboard
//
//  Created by Andrea Miotto on 15/09/21.
//  Copyright © 2021 Swift. All rights reserved.
//

import SwiftUI

// MARK: - Keyboard Handles Methods
@available(iOSApplicationExtension, unavailable)
extension PartialSheet {

    /// Add the keyboard offset
    func keyboardShow(notification: Notification) {
        let endFrame = UIResponder.keyboardFrameEndUserInfoKey
        if let rect: CGRect = notification.userInfo![endFrame] as? CGRect {
            let height = rect.height
            let bottomInset = safeAreaInsets.bottom
            withAnimation(manager.slideAnimation) {
                self.keyboardOffset = height - bottomInset
            }
        }
    }

    /// Remove the keyboard offset
    func keyboardHide(notification: Notification) {
        DispatchQueue.main.async {
            withAnimation(manager.slideAnimation) {
                self.keyboardOffset = 0
            }
        }
    }
    
    /// Dismiss the keyboard
    func dismissKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        }
    }
}
