//
//  File.swift
//  Banking sys
//
//  Created by Gayathri V on 23/07/21.
//

import Foundation

protocol ShoppingTransactionProtocol {
    func swipe(amount: Double, in account : Int, with cardNumber : Int)
    func cashback(amount : Double) -> Double
}
