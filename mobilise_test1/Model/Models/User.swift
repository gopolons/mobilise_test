//
//  User.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 26/11/2021.
//

import Foundation

struct User: Codable, Hashable {
    var id: Int
    var accounts: [Account]
}
