//
//  TempDB.swift
//  banking program
//
//  Created by Gayathri V on 22/07/21.
//

import Foundation

class BankData {
    var accountList : [Account] = [Account(accountNumber: 1234567890, accountHolderName: "Alex", balance: 2500.0), Account(accountNumber: 9012345678, accountHolderName: "Ben", balance: 5600.0), Account(accountNumber: 5678901234, accountHolderName: "Charlie", balance: 1680.0)]
    
    var creditCardList : [CreditCard] = [CreditCard(cardNumber: 1234, cvvNumber: 123, cardExpiryDate: "2029/08", pinNumber: 102, creditLimit: 200000.0),CreditCard(cardNumber: 5678, cvvNumber: 435, cardExpiryDate: "2022/02", pinNumber: 877, creditLimit: 400000.0)]
    
    var debitCardList : [DebitCard] = [DebitCard(accNumber: 1234567890, cardNumber: 7890, cvvNumber: 212, cardExpiryDate: "2024/06", pinNumber: 180),DebitCard(accNumber: 9012345678, cardNumber: 6789, cvvNumber: 043, cardExpiryDate: "2027/05", pinNumber: 200)]
}
