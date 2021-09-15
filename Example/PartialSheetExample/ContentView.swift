//
//  ContentView.swift
//  PartialSheetExample
//
//  Created by Bobby Schultz on 1/29/20.
//  Copyright © 2020 Swift. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    Section {
                        Text("""
                    Partial Sheet modifier will display a totally custom sheet with an height based on its content.\n
                    In this way the sheet will cover the screen only for the space it will need.\n
                    On iPad and Mac devices it will present a normal .sheet view.
                    """)
                            .font(.footnote)
                            .padding()
                    }
                    Section("Examples") {
                        NavigationLink(
                            destination: BaseExample(),
                            label: {Text("Base Example")
                            })
                        NavigationLink(
                            destination: TextfieldExample(),
                            label: {Text("Textfield Example")
                            })
                        NavigationLink(
                            destination: ListExample(),
                            label: {Text("List Example")
                            })
                        NavigationLink(
                            destination: PushNavigationExample(),
                            label: {Text("Push Navigation Example")
                            })
                        NavigationLink(
                            destination: DatePickerExample(),
                            label: {Text("DatePicker Example")
                            })
                        NavigationLink(
                            destination: PickerExample(),
                            label: {Text("Picker Example")
                            })
                        NavigationLink(
                            destination: BlurredExample(),
                            label: {Text("Blurred Example")
                            })
                        NavigationLink(
                            destination: AnimationContentExample(),
                            label: {Text("AnimationContent Example")
                            })
                        NavigationLink(
                            destination: HandleBarFreeExample(),
                            label: {Text("HandleBarFree Example")
                            })
                    }
                }
            }
            .navigationBarTitle("Partial Sheet")
        }
        .attachPartialSheetToRoot()
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PartialSheetManager())
    }
}
