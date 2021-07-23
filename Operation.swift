//
//  Operation.swift
//  Bank System Program
//
//  Created by Gayathri V on 22/07/21.
//

import Foundation

class Operation : BankData { 
    
    var atmOperation = ATMOperation()
    var shoppingOperation = ShoppingOperation()
    var bankOperation = BankOperation()
    
    func startCustomerService() {
        while (true) {
            print("Please Enter an option to begin service - \n 1. Bank Transaction \n 2. ATM Transaction \n 3. Shopping Payment Transaction")
            let str = readLine()
            let choice = Int(str ?? "-1")
            switch(choice) {
            case 1 :
                print("Starting Bank Account services...")
                bankOperation.bankProcess()
            case 2 :
                print("Starting ATM Transaction services...")
                atmOperation.performOperation()
                
            case 3 :
                print("Starting Shopping Payment Transaction request...")
                shoppingOperation.performOperation()
            default:
                print("Enter correct choice !!")
                
            }
        }
        
    }
    func addNewAccount(new account: Account) {
        accountList.append(account)
    }
    func addNewCreditCard(new card: CreditCard) {
        creditCardList.append(card)
    }
    func addNewDebitCard(new card: DebitCard) {
        debitCardList.append(card)
    }
}

