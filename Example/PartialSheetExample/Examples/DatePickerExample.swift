//
//  DatePickerExample.swift
//  PartialSheetExample
//
//  Created by Rasmus Styrk on 14/08/2020.
//  Copyright © 2020 Swift. All rights reserved.
//

import SwiftUI

struct DatePickerExample: View {
    @State private var isSheetPresented = false

    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                isSheetPresented = true
            }, label: {
                Text("Display the DatePickerExample Sheet")
            })
            .padding()
            Spacer()
        }
        .partialSheet(isPresented: $isSheetPresented,
                      content: DatePickerSheetView.init)
        .navigationBarTitle("DatePickerExample Example")
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DatePickerExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DatePickerSheetView()
        }
        .attachPartialSheetToRoot()
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(PartialSheetManager())
    }
}

struct DatePickerSheetView: View {
    @State private var date: Date = Date()

    var body: some View {
        VStack {
            VStack {
                Text("Settings Panel").font(.headline)
                DatePicker("Date", selection: $date)
            }
            .padding()
            .frame(height: 270)
        }
    }
}
