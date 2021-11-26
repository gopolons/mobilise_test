//
//  PaymentView.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 25/11/2021.
//

import SwiftUI

struct PaymentView: View {
    
    @StateObject var modelData = PaymentViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        AmountSelector(amount: $modelData.amount)
                            .padding(.vertical)
                        
                        if modelData.userAccounts != [] {
                            AccountSelector(accounts: modelData.userAccounts, selectedAcc: $modelData.selectedAccount)
                                
                            
                            AccountCell(account: $modelData.userAccounts[modelData.selectedAccount])
                        }
                    }

                } header: {
                    
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        GetPaidButton(isLoading: $modelData.loading, function: {
                            modelData.sendRequest()
                        })
                            .disabled(modelData.userAccounts == [] ? true : false)
                        
                        Spacer()
                    }


                } header: {
                    
                }
                
            }
            .navigationTitle("Get payment")
            .onAppear {
                modelData.onAppear()
            }
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
