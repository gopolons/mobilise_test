//
//  AccountCell.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 26/11/2021.
//

import SwiftUI

struct AccountCell: View {
    
    @Binding var account: Account
    
    var body: some View {
        VStack {
            HStack {
                BankImageView(card: account.card)
                
                VStack(alignment: .leading) {
                    Text(account.accountName)
                    Text(cardNum: account.cardNum)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(account.expirationDate)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                }
                
                Spacer()
                
                Text("£\(String(format: "%.2f", account.balance))")
                    .font(.title)
                
            }
        }
    }
}

struct AccountCell_Previews: PreviewProvider {
    
    @State static var previewAcc: Account = Account(id: 0, cardNum: "3953", balance: 350.43, accountName: "Personal", expirationDate: "04/21", card: "mastercard")
    
    static var previews: some View {
        AccountCell(account: $previewAcc)
    }
}
