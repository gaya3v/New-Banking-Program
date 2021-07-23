//
//  ATMOperation.swift
//  Bank System Program
//
//  Created by Gayathri V on 22/07/21.
//

import Foundation

class ATMOperation : BankData, BalanceCheckProtocol, ATMTransactionProtocol, TransactionProtocol {
    
    
    //MARK: - get card number
    var currentCardNumber : Int = 0
    var accountNumberOnCard : Int = 0
    var accountInProcess : Account!
    var accountBalance : Double = 0.0
    
    func performOperation() {
        getCardNumber()
        if pinValidation(number: currentCardNumber) {
            accountBalance = getAccountBalance()
            atmTransaction()
        }
        else {
            performOperation()
        }
        
    }
    func hasSufficientBalanceForTransaction(amount: Double) -> Bool {
        //   guard let balance = accountList[account] else { return false }
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
    
    func taxCharges(amount: Double) -> Double {
        if amount > 100 {
            let reductionAmt = amount * 0.04
            print("Transaction Charges - USD $",reductionAmt)
            return reductionAmt
        }
        else {
            let reductionAmt = amount * 0.02
            print("Transaction Charges - USD $",reductionAmt)
            return reductionAmt
        }
    }
    
    func withdraw(amount: Double, in account : Int) {
        if hasSufficientBalanceForTransaction(amount: amount) {
            if isValidAmount(amount: amount) {
                print("Withdraw amount - USD $",amount)
                accountBalance -= amount
                let charges = taxCharges(amount: amount)
                accountBalance -= charges
                print("Balance in account after withdrawal is USD $",accountBalance)
            }
            else {
                print("Enter amount in terms of USD $5")
            }
        }
        else {
            print("Insufficient funds for transaction")
        }
    }
    
    func deposit(amount: Double, in account : Int) {
        //  var balance = accountList[account] ?? 0.0
        print("Deposit amount - USD ",amount)
        accountBalance += amount
        print("Balance in account after deposit is USD $",accountBalance)
    }
    func showBalance(in account : Int) {
        // var balance = accountList[account] ?? 0.0
        print("BALANCE : USD $",accountBalance)
    }
    
    func isValidAmount(amount: Double) -> Bool {
        if amount.truncatingRemainder(dividingBy: 5.0) == 0 {
            return true
        }
        return false
    }
    func getCardNumber() {
        print("Enter card number to begin the process : ")
        let cardNum = readLine()
        currentCardNumber = (Int(cardNum ?? "")) ?? 0
    }
    
    func isCardValid (number : Int) -> Int {
        
        for card in creditCardList {
            if card.cardNumber == number {
                print("Credit cards cannot be used in ATM machine !")
                return 0
            }
        }
        for card in debitCardList {
            if card.cardNumber == number {
                print("Valid Debit Card !")
                accountNumberOnCard = card.accNumber
                return 1
            }
        }
        print("Invalid card details")
        return -1
    }
    func pinValidation(number : Int) ->  Bool {
        if isCardValid(number: number) > 0 {
            print("Enter PIN number : ")
            let pinNumber = readLine() ?? ""
            for card in debitCardList {
                if card.cardNumber == number {
                    if card.pinNumber == Int(pinNumber) {
                        print("Welcome \(card.accNumber)!")
                        return true
                    }
                }
            }
            print("Invalid PIN\n")
            return false
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
    func atmTransaction() {
        while (true) {
            //MARK: - check for min balance of $100
            if (hasMinimumBalance(account: accountNumberOnCard)) {
                print("Please enter a choice - \n 1. Withdraw \n 2. Deposit \n 3. Show \n 4. Quit")
                let str = readLine()
                let choice = Int(str ?? "-1")
                switch(choice) {
                case 1 :
                    print("Enter amount : ")
                    let amount = readLine()
                    withdraw(amount: (Double(amount!)) ?? 0.0, in: accountNumberOnCard)
                case 2 :
                    print("Enter amount : ")
                    let amount = readLine()
                    deposit(amount: (Double(amount!)) ?? 0.0, in: accountNumberOnCard)
                case 3 :
                    showBalance(in: accountNumberOnCard)
                case 4:
                    print("Thank you for banking with us!")
                    exit(0)
                    
                default:
                    print("Enter correct choice !!")
                    
                }
            }
            else {
                print("Bank account has balance below 100, cannot do transactions.")
                break
            }
            
        }
        
    }
}
