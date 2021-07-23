//
//  CardProtocol.swift
//  ATM Model
//
//  Created by Gayathri V on 20/07/21.
//

import Foundation

protocol ATMTransactionProtocol {
    func isValidAmount(amount : Double) -> Bool
    func isCardValid(number : Int) -> Int
}

