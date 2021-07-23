//
//  ShoppingOperation.swift
//  Bank System Program
//
//  Created by Gayathri V on 22/07/21.
//

import Foundation

class ShoppingOperation : BankData, CardPaymentProtocol, BalanceCheckProtocol, ShoppingTransactionProtocol, CreditLimitCheckProtocol {


    var currentCardNumber : Int = 0
    var creditLimit : Double = 0.0
    var accountNumberOnCard : Int = 0
    var accountInProcess : Account!
    var accountBalance : Double = 0.0
    
    func performOperation() {
        getCardNumber()
        if pinValidation(number: currentCardNumber) {
            shoppingTransaction()
        }
        else {
            performOperation()
        }
    }
    
    func getCardNumber() {
        print("Enter card number to begin the process : ")
        let cardNum = readLine()
        currentCardNumber = (Int(cardNum ?? "")) ?? 0
    }
    
    func isCardValid (number : Int) -> Int {
        
        for card in creditCardList {
            if card.cardNumber == number {
                print("Valid Credit Card !")
                currentCardNumber = card.cardNumber
                return 1
            }
        }
        for card in debitCardList {
            if card.cardNumber == number {
                print("Valid Debit Card !")
                currentCardNumber = card.cardNumber
                accountNumberOnCard = card.accNumber
                return 2
            }
        }
        print("Invalid card details")
        return 0
    }
    
    func pinValidation(number : Int) ->  Bool {
        if isCardValid(number: number) == 1 {
            print("Enter Credit card PIN number : ")
            let pinNumber = readLine() ?? ""
            for card in creditCardList {
                if card.cardNumber == number {
                    if card.pinNumber == Int(pinNumber) {
                        creditLimit = getCreditLimit()
                        return true
                    }
                }
            }
            print("Invalid pin")
            return false
        }
        else if isCardValid(number: number) == 2 {
            print("Enter Debit card PIN number : ")
            let pinNumber = readLine() ?? ""
            for card in debitCardList {
                if card.cardNumber == number {
                    if card.pinNumber == Int(pinNumber) {
                        accountBalance = getAccountBalance()
                        return true
                    }
                }
            }
            print("Invalid pin")
            return false
        }
        return false
    }
    
    func isPaymentWithinLimit(amount: Double) -> Bool {

        if amount > creditLimit {
            return false
        }
        return true
    }

    func swipe(amount: Double, in account : Int, with cardNumber : Int) {
        if isCardValid(number: cardNumber) == 1 {
            if isPaymentWithinLimit(amount: amount) {
                print("Swipe amount - USD $",amount)
                    creditLimit -= amount
                    let bonus = cashback(amount: amount)
                    creditLimit += bonus
                    print("Eligible Limit amount after payment & cashback is USD $",creditLimit)
            }
        }
        else if isCardValid(number: cardNumber) == 2 {
            if hasSufficientBalanceForTransaction(amount: amount) {
                print("Swipe amount - USD $",amount)
                    accountBalance -= amount
                    let bonus = cashback(amount: amount)
                    accountBalance+=bonus
                    print("Balance in account after cashback is USD $",accountBalance)
                
            }
            else {
                print("Insufficient funds for transaction")
            }
        }
    }
    
    func cashback(amount: Double) -> Double {
        let bonus = amount * 0.01
        print("Cashback on Swiping - USD $",bonus)
        return bonus
    }
    func hasSufficientBalanceForTransaction(amount: Double) -> Bool {
        if amount > accountBalance {
            return false
        }
        return true
    }
    
    func hasMinimumBalance(account: Int) -> Bool {
        if accountBalance > 100 {
            return true
        }
        return false
    }
    func isfundWithinCreditLimit() -> Bool {
        if creditLimit > 100 {
            return true
        }
        return false
    }
    func getAccountBalance () -> Double {
        for acc in accountList {
            if acc.accountNumber == accountNumberOnCard {
                accountBalance = acc.balance
                //print(accountBalance)
                accountInProcess = acc
                return acc.balance
            }
        }
        return 0.0
    }
    func getCreditLimit () -> Double {
        for card in creditCardList {
            if card.cardNumber == currentCardNumber {
                creditLimit = card.creditLimit
            }
        }
        return creditLimit
    }
    func shoppingTransaction() {
        while (true) {
            //MARK: - check for min balance of $100
            if hasMinimumBalance(account: accountNumberOnCard) || isfundWithinCreditLimit() {
                print("Confirm your payment transaction - \n Enter y to Swipe amount \n Enter n to Cancel payment")
                let str = readLine()
                switch(str) {
                case "y" :
                    print("Enter amount : ")
                    let amount = readLine()
                    swipe(amount: (Double(amount!)) ?? 0.0, in: accountNumberOnCard, with: currentCardNumber)
                case "n" :
                    print("Cancelling card payment! Exiting...")
                    exit(0)

                default:
                    print("Enter correct choice !!")
                    
                }
            }
            else {
                print("Funds below 100, cannot do transaction.")
                break
            }
            
        }
        
    }
}
