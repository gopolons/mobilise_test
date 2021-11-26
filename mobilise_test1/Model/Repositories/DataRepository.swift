//
//  DataRepository.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 26/11/2021.
//

import Foundation

//Interface for viewModel interaction with api service

protocol DataRepositoryProtocol {
    func fetchUser(completion: @escaping (User?, NetError?) -> Void)
    
    func sendPaymentRequest(account: Account, value: Double, completion: @escaping (ApiResponse?, NetError?) -> Void)
}

final class DataRepository: DataRepositoryProtocol {

    private var apiService: ApiServiceProtocol
    private var connectionManager: Connectivity
    
    func fetchUser(completion: @escaping (User?, NetError?) -> Void) {
        if connectionManager.isNetworkAvailable() {
            apiService.fetchUser { data, err in
                guard err == nil else {
                    completion(nil, err)
                    return
                }
                completion(data, nil)
            }
        } else {
            completion(nil, .noConnection)
        }
    }
    
    func sendPaymentRequest(account: Account, value: Double, completion: @escaping (ApiResponse?, NetError?) -> Void) {
        if connectionManager.isNetworkAvailable() {
            apiService.sendPaymentRequest(account: account, value: value) { response, err in
                guard err == nil else {
                    completion(nil, err)
                    return
                }
                completion(response, nil)
            }
        } else {
            completion(nil, .noConnection)
        }
    }
    
    init(apiService: ApiServiceProtocol = ApiService(), connectionManager: Connectivity = Connectivity()) {
        self.apiService = apiService
        self.connectionManager = connectionManager
    }
    
}
