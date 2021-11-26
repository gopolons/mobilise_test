//
//  BankImageView.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 26/11/2021.
//

import SwiftUI

struct BankImageView: View {
    
    let card: String
    
    var body: some View {
        Image(card)
            .resizable()
            .frame(width: 75, height: 75)
    }
}

struct BankImageView_Previews: PreviewProvider {
    static var previews: some View {
        BankImageView(card: "mastercard")
    }
}
