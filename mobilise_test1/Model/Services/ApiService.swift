//
//  ApiService.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 26/11/2021.
//

import Foundation

protocol ApiServiceProtocol {
    func fetchUser(completion: @escaping (User?, NetError?) -> Void)
    
    func sendPaymentRequest(account: Account, value: Double, completion: @escaping (ApiResponse?, NetError?) -> Void)
}

final class ApiService: ApiServiceProtocol {
    
//    private var parser: DataParsingProtocol
    
    private var user = User(id: 200045, accounts: [Account(id: 34234, cardNum: "5683", balance: 50.43, accountName: "Personal", expirationDate: "04/23", card: "visa"), Account(id: 33958, cardNum: "4853", balance: 130.48, accountName: "Business", expirationDate: "08/25", card: "mastercard")])
    
    func fetchUser(completion: @escaping (User?, NetError?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(self.user, nil)
        }
    }
    
    func sendPaymentRequest(account: Account, value: Double, completion: @escaping (ApiResponse?, NetError?) -> Void) {
        guard let index = self.user.accounts.firstIndex(of: account) else {
            completion(nil, NetError.fail)
            return
        }
        self.user.accounts[index].balance += value
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completion(ApiResponse.success, nil)
        }
    }
    
    
}
