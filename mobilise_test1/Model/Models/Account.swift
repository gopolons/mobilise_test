//
//  Account.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 26/11/2021.
//

import Foundation

struct Account: Codable, Hashable {
    var id: Int
    var cardNum: String
    var balance: Double
    var accountName: String
    var expirationDate: String
    var card: String
}
