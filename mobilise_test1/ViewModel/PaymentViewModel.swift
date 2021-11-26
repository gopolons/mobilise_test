//
//  PaymentViewModel.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 26/11/2021.
//

import SwiftUI

final class PaymentViewModel: ObservableObject {
    private var dataRepo: DataRepositoryProtocol
    
    @Published var userAccounts: [Account] = []
    
    @Published var selectedAccount = 0
    
    @Published var amount = ""

    @Published var loading = false
    
    func onAppear() {
        dataRepo.fetchUser { data, err in
            guard err == nil else {
                switch err {
                case .fail:
                    return
                case .noConnection:
                    return
                default:
                    return
                }
            }
            
            self.userAccounts.append(contentsOf: data!.accounts)
        }
    }
    
    func sendRequest() {
        let amt = Double(self.amount)!
        self.amount = ""
        dataRepo.sendPaymentRequest(account: userAccounts[selectedAccount], value: amt) { response, err in
            guard err == nil else {
                switch err {
                case .fail:
                    withAnimation {
                        self.loading.toggle()
                    }
                    return
                case .noConnection:
                    withAnimation {
                        self.loading.toggle()
                    }
                    return
                default:
                    return
                }
            }
            if response == .success {
                self.dataRepo.fetchUser { data, err in
                    guard err == nil else {
                        switch err {
                        case .fail:
                            withAnimation {
                                self.loading.toggle()
                            }
                            return
                        case .noConnection:
                            withAnimation {
                                self.loading.toggle()
                            }
                            return
                        default:
                            return
                        }
                    }
                    self.userAccounts.removeAll()
                    self.userAccounts.append(contentsOf: data!.accounts)
                    withAnimation {
                        self.loading.toggle()
                    }

                }
            }
        }
    }
    
    init(dataRepo: DataRepositoryProtocol = DataRepository()) {
        self.dataRepo = dataRepo
    }
}
