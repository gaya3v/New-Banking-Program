//
//  CreditLimitCheckProtocol.swift
//  Banking sys
//
//  Created by Gayathri V on 23/07/21.
//

import Foundation

protocol CreditLimitCheckProtocol {
    func isPaymentWithinLimit(amount : Double) -> Bool
}
