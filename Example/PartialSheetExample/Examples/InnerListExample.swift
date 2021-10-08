//
//  InnerListExample.swift
//  PartialSheetExample
//
//  Created by hajime-nakamura on 2021/10/08.
//  Copyright © 2021 Swift. All rights reserved.
//

import SwiftUI

struct InnerListExample: View {

    @EnvironmentObject var partialSheetManager : PartialSheetManager
    @State var dragGesture: DragGesture = .init()

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                self.partialSheetManager.showPartialSheet({
                     print("normal sheet dismissed")
                }) {
                    InnerListView().highPriorityGesture(dragGesture)
                }
            }, label: {
                Text("Display the Partial Sheet")
            })
                .padding()
            Spacer()
        }
        .navigationBarTitle("Normal Example")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct InnerListView: View {
    var body: some View {
        List {
            ForEach(0..<30) { i in
                Button {
                    print(i)
                } label: {
                    Text("\(i)")
                }
            }
        }
    }
}

struct InnerListExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InnerListExample()
        }
        .addPartialSheet()
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(PartialSheetManager())
    }
}
