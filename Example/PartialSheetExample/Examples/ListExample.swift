//
//  ListExample.swift
//  PartialSheetExample
//
//  Created by Andrea Miotto on 29/4/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import SwiftUI

struct ListExample: View {
    @State private var isSheetPresented = false
    @State private var selectedIndex: Int = 0

    var body: some View {
        List(0...12, id: \.self) { (index) in
            Button(action: {
                selectedIndex = index
                isSheetPresented = true
            }, label: {
                Text("Item: \(index)")
            })
        }
        .partialSheet(isPresented: $isSheetPresented, content: {
            Text("Item: \(selectedIndex)")
        })
        .navigationBarTitle(Text("List Example"))
    }
}

struct ListExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListExample()
        }
        .attachPartialSheetToRoot()
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(PartialSheetManager())
    }
}
