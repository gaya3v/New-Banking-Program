//
//  CreditCard.swift
//  banking program
//
//  Created by Gayathri V on 22/07/21.
//

import Foundation

class CreditCard : Card {
    var creditLimit : Double
    init(cardNumber : Int, cvvNumber : Int, cardExpiryDate : String, pinNumber : Int, creditLimit : Double) {
        self.creditLimit = creditLimit
        super.init(cardNumber: cardNumber, cvvNumber: cvvNumber, cardExpiryDate: cardExpiryDate, pinNumber: pinNumber)
    }
}
