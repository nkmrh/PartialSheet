//
//  PickerExample.swift
//  PartialSheetExample
//
//  Created by Rasmus Styrk on 14/08/2020.
//  Copyright © 2020 Swift. All rights reserved.
//

import SwiftUI

struct PickerExample: View {
    @State private var isSheetPresented = false

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isSheetPresented = true
            }, label: {
                Text("Display the PickerExample Sheet")
            })
            .padding()
            Spacer()
        }
        .partialSheet(isPresented: $isSheetPresented,
                      content: PickerSheetView.init)
        .navigationBarTitle("PickerExample Example")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct PickerExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PickerSheetView()
        }
        .attachPartialSheetToRoot()
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(PartialSheetManager())
    }
}

struct PickerSheetView: View {
    var strengths = ["Mild", "Medium", "Mature"]
    @State private var selectedStrength = 0

    var body: some View {
        VStack {
            VStack {
                Text("Settings Panel").font(.headline)
                Picker(selection: $selectedStrength, label: EmptyView()) {
                    ForEach(0 ..< strengths.count) {
                        Text(self.strengths[$0])
                    }
                }.onTapGesture {
                    // Fixes issue with scroll
                }
            }
            .padding()
            .frame(height: 250)
        }
    }
}
