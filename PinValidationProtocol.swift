//
//  PinValidationProtocol.swift
//  banking program
//
//  Created by Gayathri V on 22/07/21.
//

import Foundation

protocol PinValidationProtocol {
    func isCardPinValid(for cardNumber : Int) -> Bool
    func isCardActive(for cardNumber : Int) -> Bool
    func getCardType(for cardNumber : Int) -> Int
}
