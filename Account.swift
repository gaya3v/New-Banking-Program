//
//  Account.swift
//  Banking sys
//
//  Created by Gayathri V on 23/07/21.
//

import Foundation

class Account {
    var accountNumber : Int
    var accountHolderName : String
    var balance : Double
    
    init (accountNumber : Int, accountHolderName : String, balance : Double) {
        self.accountNumber = accountNumber
        self.accountHolderName = accountHolderName
        self.balance = balance
    }
}
