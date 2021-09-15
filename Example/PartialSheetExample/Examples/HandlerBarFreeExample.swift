//
//  HandleBarFreeExample.swift
//  PartialSheetExample
//
//  Created by Gijs van Veen on 12/05/2021.
//  Copyright © 2021 Swift. All rights reserved.
//

import SwiftUI

struct HandleBarFreeExample: View {
    @State private var isSheetPresented = false
    let sheetStyle = PartialSheetStyle(background: .solid(Color(UIColor.tertiarySystemBackground)),
                                       handleBarStyle: .none,
                                       iPadCloseButtonColor: Color(UIColor.systemGray2),
                                       enableCover: true,
                                       coverColor: Color.black.opacity(0.4),
                                       blurEffectStyle: nil,
                                       cornerRadius: 10,
                                       minTopDistance: 110
    )

    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                isSheetPresented = true
            }, label: {
                Text("Display the HandleBarFreeExample Sheet")
            })
                .padding()
            Spacer()
        }
        .partialSheet(isPresented: $isSheetPresented, style: sheetStyle,
                      content: {
            HandleBarFreeSheetView(isSheetPresented: $isSheetPresented)
        })
        .navigationBarTitle("HandleBarFreeExample Example")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HandleBarFreeExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HandleBarFreeSheetView(isSheetPresented: .constant(true))
        }
        .attachPartialSheetToRoot()
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(PartialSheetManager())
    }
}

struct HandleBarFreeSheetView: View {
    @State private var longer: Bool = false
    @State private var text: String = "some text"
    @Binding var isSheetPresented: Bool

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
                Button("Close Button") {
                    isSheetPresented = false
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
    }
}
