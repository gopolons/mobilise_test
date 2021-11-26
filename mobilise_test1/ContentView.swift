//
//  ContentView.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 23/11/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PaymentView()
            .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
