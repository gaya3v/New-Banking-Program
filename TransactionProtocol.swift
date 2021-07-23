//
//  TransactionChargeProtocol.swift
//  ATM Model
//
//  Created by Gayathri V on 20/07/21.
//

import Foundation

protocol TransactionProtocol {
    func withdraw(amount: Double, in account : Int)
    func deposit(amount: Double, in account : Int)
    func showBalance(in account : Int)
    func taxCharges(amount : Double) -> Double
}
