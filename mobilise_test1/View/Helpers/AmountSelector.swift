//
//  AmountSelector.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 25/11/2021.
//

import SwiftUI

struct AmountSelector: View {
    
    @Binding var amount: String
    
    var body: some View {
        
        HStack {
            Text("£")
            TextField("0.00", text: $amount)
        }
        .font(.title)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .keyboardType(.decimalPad)

        
            
    }
}

struct AmountSelector_Previews: PreviewProvider {
    
    @State static var previewBind = ""
    
    static var previews: some View {
        AmountSelector(amount: $previewBind)
    }
}
