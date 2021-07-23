//
//  AccountOperationsProtocol.swift
//  ATM Model
//
//  Created by Gayathri V on 20/07/21.
//

import Foundation

protocol CardPaymentProtocol {
    func swipe(amount: Double, in account : Int, with cardNumber : Int)
    func cashback(amount : Double) -> Double
    func getCardNumber()
    func pinValidation(number : Int) ->  Bool
}

