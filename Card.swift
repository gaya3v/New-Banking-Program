//
//  CreditCard.swift
//  banking program
//
//  Created by Gayathri V on 22/07/21.
//

import Foundation

class Card {
    private (set) var cardNumber : Int
    private (set) var cvvNumber : Int
    private (set) var cardExpiryDate : String
    private (set) var pinNumber : Int
    init(cardNumber : Int, cvvNumber : Int, cardExpiryDate : String, pinNumber : Int) {
        self.cardNumber = cardNumber
        self.cvvNumber = cvvNumber
        self.cardExpiryDate = cardExpiryDate
        self.pinNumber = pinNumber
    }
}


