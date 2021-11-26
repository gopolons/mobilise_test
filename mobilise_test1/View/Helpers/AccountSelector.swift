//
//  AccountSelector.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 25/11/2021.
//

import SwiftUI

struct AccountSelector: View {
    
    let accounts: [Account]
    
    @Binding var selectedAcc: Int
    
    var body: some View {
        HStack {
            Text("Payment recepient account")
            
            Spacer()
            
            Picker(selection: $selectedAcc) {
                
                ForEach(0...(accounts.count - 1), id: \.self) { acc in
                    HStack {
                        Text("\(accounts[acc].accountName)")
                    }
                    .tag(acc)

                }


            } label: {
                Text(accounts[selectedAcc].accountName)
            }
            .pickerStyle(MenuPickerStyle())

        }
    }
}

struct AccountSelector_Previews: PreviewProvider {
    
    @State static var previewAcc: [Account] = [Account(id: 0, cardNum: "3953", balance: 350.43, accountName: "Personal", expirationDate: "04/21", card: "mastercard")]
    
    @State static var previewBind = 0
    
    static var previews: some View {
        AccountSelector(accounts: previewAcc, selectedAcc: $previewBind)
    }
}
