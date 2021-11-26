//
//  TextExtensions.swift
//  mobilise_test1
//
//  Created by Georgy Polonskiy on 26/11/2021.
//

import SwiftUI

extension Text {
    init(cardNum: String) {
        
        let text = "•••• \(cardNum.suffix(4))"
            
        self.init(text)
    }
}
