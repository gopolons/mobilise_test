//
//  PaymentViewModel.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 26/11/2021.
//

import SwiftUI
import SPAlert

//View model for payment view

final class PaymentViewModel: ObservableObject {
    private var dataRepo: DataRepositoryProtocol
    
    @Published var userAccounts: [Account] = []
    
    @Published var selectedAccount = 0
    
    @Published var amount = ""

    @Published var loading = false
    
    @Published var alert = false
    
    @Published var alertMessage = ""
    
    @Published var alertTitle = ""
    
    @Published var alertPreset = SPAlertIconPreset.done
    
    @Published var noConnection = false
    
    @Published var reconnecting = false
    
    private func failError() {
        self.alertTitle = "Error"
        self.alertMessage = "Failure to retrieve data"
        self.alertPreset = .error
        self.alert.toggle()
    }
    
    private func connectionError() {
        self.alertTitle = "No connection"
        self.alertMessage = "Check your internet connection"
        self.alertPreset = .error
        self.noConnection = true
        self.alert.toggle()
    }
    
    
    private func successAlert() {
        self.alertTitle = "Success"
        self.alertMessage = "Your transaction was successful"
        self.alertPreset = .done
        self.alert.toggle()

    }
    
    private func wrongInput() {
        self.alertTitle = "Error"
        self.alertMessage = "Please make sure that you input a correct amount"
        self.alertPreset = .error
        self.alert.toggle()

    }


    func reconnect() {
        
        dataRepo.fetchUser { data, err in
            guard err == nil else {
                self.connectionError()
                self.reconnecting.toggle()
                return
            }
            self.noConnection = false
            self.userAccounts.append(contentsOf: data!.accounts)
        }
    }
    
    func onAppear() {
        dataRepo.fetchUser { data, err in
            guard err == nil else {
                switch err {
                case .fail:
                    self.failError()
                    return
                case .noConnection:
                    self.connectionError()
                    return
                default:
                    return
                }
            }
            
            self.userAccounts.append(contentsOf: data!.accounts)
        }
    }
    
    func sendRequest() {
        if let amt = Double(self.amount) {
            guard amt > 0 else {
                self.wrongInput()
                withAnimation {
                    self.loading.toggle()
                }
                return
            }
            self.amount = ""
            
            dataRepo.sendPaymentRequest(account: userAccounts[selectedAccount], value: amt) { response, err in
                guard err == nil else {
                    switch err {
                    case .fail:
                        self.failError()
                        withAnimation {
                            self.loading.toggle()
                        }
                        return
                    case .noConnection:
                        self.connectionError()
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
                                self.failError()
                                withAnimation {
                                    self.loading.toggle()
                                }
                                return
                            case .noConnection:
                                self.connectionError()
                                withAnimation {
                                    self.loading.toggle()
                                }
                                return
                            default:
                                return
                            }
                        }
                        self.successAlert()
                        self.userAccounts.removeAll()
                        self.userAccounts.append(contentsOf: data!.accounts)
                        withAnimation {
                            self.loading.toggle()
                        }

                    }
                }
            }
        } else {
            withAnimation {
                self.loading.toggle()
            }
            self.wrongInput()

        }
        
        
        
    }
    
    init(dataRepo: DataRepositoryProtocol = DataRepository()) {
        self.dataRepo = dataRepo
    }
}
