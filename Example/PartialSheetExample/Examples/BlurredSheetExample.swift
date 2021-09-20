//
//  BlurredSheetExample.swift
//  PartialSheetExample
//
//  Created by Rasmus Styrk on 14/08/2020.
//  Copyright © 2020 Swift. All rights reserved.
//

import SwiftUI

struct BlurredExample: View {
    @State var isSheetPresented = false
    let sheetStyle = PartialSheetStyle(background: .blur(.ultraThinMaterial),
                                       accentColor: Color(UIColor.systemGray2),
                                       enableCover: true,
                                       coverColor: Color.black.opacity(0.4),
                                       blurEffectStyle: nil,
                                       cornerRadius: 10,
                                       minTopDistance: 350
    )

    var body: some View {
        VStack {
            Spacer()
            Button(action: {
                isSheetPresented = true
            }, label: {
                Text("Display the BlurredExample Sheet")
            })
            .padding()
            Spacer()
            HStack {
                Rectangle().foregroundColor(Color.blue).frame(width: 75, height: 75)
                Rectangle().foregroundColor(Color.green).frame(width: 75, height: 75)
                Rectangle().foregroundColor(Color.red).frame(width: 75, height: 75)
                Rectangle().foregroundColor(Color.yellow).frame(width: 75, height: 75)
            }
        }
        .navigationBarTitle("Blurred Example")
        .navigationViewStyle(StackNavigationViewStyle())
        .partialSheet(isPresented: $isSheetPresented,
                      style: sheetStyle,
                      content: BlurredSheetView.init)
    }
}

struct BlurredExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BlurredExample()
        }
        .attachPartialSheetToRoot()
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(PartialSheetManager())
    }
}

struct BlurredSheetView: View {
    @State private var selectedStrength = 0

    var body: some View {
        VStack {
            Group {
                Text("Settings Panel").font(.headline).foregroundColor(Color.white)
                Text("The background of the sheet is blurred").font(.subheadline).foregroundColor(Color.white)
                Text("We also set a minTopDistance").font(.subheadline).foregroundColor(Color.white)
                Text("The background of the sheet is blurred").font(.subheadline).foregroundColor(Color.white)
                Text("We also set a minTopDistance").font(.subheadline).foregroundColor(Color.white)
                Text("The background of the sheet is blurred").font(.subheadline).foregroundColor(Color.white)
                Text("We also set a minTopDistance").font(.subheadline).foregroundColor(Color.white)
                Text("The background of the sheet is blurred").font(.subheadline).foregroundColor(Color.white)
                Text("We also set a minTopDistance").font(.subheadline).foregroundColor(Color.white)
                Spacer()
            }
            .padding()
        }
    }
}
