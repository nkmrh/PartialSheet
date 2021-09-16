//
//  NormalExample.swift
//  PartialSheetExample
//
//  Created by Andrea Miotto on 29/4/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import SwiftUI

struct BaseExample: View {
    @State private var isSheetPresented = false

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isSheetPresented = true
            }, label: {
                Text("Display the Partial Sheet")
            })
                .padding()
            Spacer()
        }
        .partialSheet(isPresented: $isSheetPresented,
                      content: SheetView.init)
        .navigationBarTitle("Normal Example")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NormalExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BaseExample()
        }
        .attachPartialSheetToRoot()
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(PartialSheetManager())
    }
}

struct SheetView: View {
    @State private var longer: Bool = false
    @State private var text: String = "some text"

    var body: some View {
        VStack {
            Group {
                Text("Settings Panel")
                    .font(.headline)

                TextField("TextField", text: self.$text)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color(UIColor.systemGray2), lineWidth: 1)
                )

                Toggle(isOn: self.$longer) {
                    Text("Advanced")
                }
            }
            .padding()
            .frame(height: 50)
            if self.longer {
                VStack {
                    Text("More settings here...")
                }
                .frame(height: 200)
            }
        }
        .padding(.vertical)
    }
}