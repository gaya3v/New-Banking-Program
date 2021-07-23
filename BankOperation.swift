//
//  main.swift
//  banking program
//
//  Created by Gayathri V on 21/07/21.
//

import Foundation

class BankOperation : BankData, BalanceCheckProtocol, TransactionProtocol {

    var accountNumber : Int = 0
    var accountInProcess : Account!
    var accountBalance : Double = 0.0
    var currentUser : String = ""
    var newAccount = Account(accountNumber: 0, accountHolderName: "", balance: 0.0)
    
    func performOperation() {
        getAccountNumber()
        accountBalance = getBalance(for: accountNumber)
        transactionProcess()
        
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
    func withdraw(amount: Double, in account : Int) {
        if hasSufficientBalanceForTransaction(amount: amount) {
                print("Withdraw amount - USD $",amount)
                accountBalance -= amount
                let charges = taxCharges(amount: amount)
                accountBalance -= charges
                print("Balance in account after withdrawal is USD $",accountBalance)
        }
        else {
            print("Insufficient funds for transaction")
        }
    }
    
    func deposit(amount: Double, in account : Int) {
        print("Deposit amount - USD ",amount)
        accountBalance += amount
        print("Balance in account after deposit is USD $",accountBalance)
    }
    
    func showBalance(in account : Int) {
        print("BALANCE : USD $",accountBalance)
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
    
    func getAccountNumber() {
        print("Enter account number to begin the process : ")
        if let accNum = readLine() {
            accountNumber = (Int(accNum)) ?? 0
        }
        if doesAccountExist() {
            print("Hello")
        }
        else {
            print("Account does not exist!! \n Create new one? y / n")
            let newAccountChoice = readLine()
            if newAccountChoice == "y" {
                createAccount()
            }
            else if newAccountChoice == "n" {
                getAccountNumber()
            }
            else {
                print("Error : Enter from given options!")
            }
        }
    }
    func doesAccountExist() -> Bool {
        for acc in accountList {
            if acc.accountNumber ==  accountNumber {
                accountInProcess = acc
                accountBalance = acc.balance
                currentUser = acc.accountHolderName
                return true
            }
        }
        return false
    }
    func getBalance(for accountNum : Int) -> Double {
        if !doesAccountExist() {
            print("Account not found! Retry.")
           getAccountNumber()
        }
        else {
            for acc in accountList {
                if acc.accountNumber == accountNum {
                    accountBalance = acc.balance
                    break
                }
            }
        }
        print("Balance is - ", accountBalance)
        accountNumber = accountNum
        return accountBalance
    }

    func createAccount() {
        print("Enter new account number : ")
        let accountNumber = readLine()
        newAccount.accountNumber = Int(accountNumber ?? "") ?? 0
        
        print("Enter new account holder's name : ")
        let accountHolderName = readLine()
        newAccount.accountHolderName = accountHolderName ?? ""
        
        print("Enter new account balance : ")
        let accountBal = readLine()
        newAccount.balance = Double(accountBal ?? "") ?? 0.0
        accountBalance = newAccount.balance
        accountList.append(newAccount)
        accountInProcess = newAccount
    }
    
    func createNewCard(for newAccount : Account, accountNum : Int) {

            print("Enter 1 for new credit card \n Enter 2 for new debit card ")
            
            let cardChoice = readLine()
            if cardChoice == "1" {
                createCreditCard(for: newAccount, accountNum: accountNum)
            }
            else if cardChoice == "2" {
                createDebitCard(for: newAccount, accountNum: accountNum)
            }
            else {
                print("Inappropriate choice")
                createNewCard(for: newAccount, accountNum: accountNum)
            }

    }
    func createCreditCard(for newAccount : Account, accountNum : Int) {
        print("Enter new credit card number : ")
        let cvvNum = readLine()
        print("Enter the CVV number of new credit card : ")
        let ccNumber = readLine()
        print("Enter the expiry date of new credit card : ")
        let expiryDate = readLine()
        print("Set new pin number : ")
        let pin = readLine()
        print("Set credit limit : ")
        let fundLimit = readLine()
        creditCardList.append(CreditCard(cardNumber: Int(ccNumber ?? "") ?? 0, cvvNumber: Int(cvvNum ?? "") ?? 0, cardExpiryDate: expiryDate ?? "",pinNumber: Int(pin ?? "") ?? 0 ,creditLimit: Double(fundLimit ?? "") ?? 0.0))
    }
    //MARK: - createDebitCard
    func createDebitCard(for newAccount : Account, accountNum : Int) {
        print("Enter new debit card number : ")
        let cvvNum = readLine()
        print("Enter the CVV number of new debit card : ")
        let ccNumber = readLine()
        print("Enter the expiry date of new debit card : ")
        let expiryDate = readLine()
        print("Set new pin number : ")
        let pin = readLine()
        
        debitCardList.append(DebitCard(accNumber: accountNum, cardNumber: Int(ccNumber ?? "") ?? 0, cvvNumber: Int(cvvNum ?? "") ?? 0, cardExpiryDate: expiryDate ?? "", pinNumber: Int(pin ?? "") ?? 0))
    }
    func transactionProcess() {
        
        while (true) {
            //MARK: - check for min balance of $100
            if (hasMinimumBalance(account: accountNumber)) {
                print("Please enter a choice - \n 1. Withdraw \n 2. Deposit \n 3. Show \n 4. Quit")
                let str = readLine()
                let choice = Int(str ?? "-1")
                switch(choice) {
                case 1 :
                    print("Enter amount : ")
                    let amount = readLine()
                    withdraw(amount: (Double(amount!)) ?? 0.0, in: accountNumber)
                case 2 :
                    print("Enter amount : ")
                    let amount = readLine()
                    deposit(amount: (Double(amount!)) ?? 0.0, in: accountNumber)
                case 3 :
                    showBalance(in: accountNumber)
                    
                case 4 :
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
    func bankProcess() {
        while (true) {
            print("Please enter a choice - \n 1. Create Account \n 2. Create Card \n 3. Perform Transaction \n 4. Summary of Accounts \n 5. Quit")
            let str = readLine()
            let choice = Int(str ?? "-1")
            switch(choice) {
            case 1 :
                createAccount()
                print("Account Created successfully")
                transactionProcess()
            case 2 :
                createNewCard(for: accountInProcess, accountNum: accountNumber)
                print("Card Created successfully")
            case 3 :
                performOperation()
            case 4:
                print("Summary of all accounts : \n")
                for account in accountList {
               
                    print("Account number : \(account.accountNumber) \t Balance : \(account.balance) ")
                }
                
            case 5 :
                print("Thank you for banking with us!")
                exit(0)
                 
            default:
                print("Enter correct choice !!")
                
            }
        }
    }
}





















//var bankData = BankDatabase()
//var userAccountDetails : [String : [Int]] = [:]
//    func createAccount() {}
//    func createNewCard() {}
//
//
//    func saveAccountToUserDetails(newAccount : Account) {
//        var flag = 0
//        if userAccountDetails.isEmpty {
//            getAccountDetailsFromDB()
//        }
//        else {
//        for key in userAccountDetails.keys {
//            if key == newAccount.accountHolderName {
//                userAccountDetails[key]?.append(newAccount.accountNumber)
//                flag = 1
//            }
//        }
//            if flag == 0 {
//                userAccountDetails[newAccount.accountHolderName] = []
//                userAccountDetails[newAccount.accountHolderName]?.append(newAccount.accountNumber)
//            }
//        }
//    }
//    func getAccountDetailsFromDB() {
//        for acc in bankData.accountList {
//            if userAccountDetails.keys.contains(acc.accountHolderName) {
//
//                    userAccountDetails.updateValue([acc.accountNumber], forKey: acc.accountHolderName)
//
//            }
//            else {
//                userAccountDetails[acc.accountHolderName] = []
//            }
//        }
//    }
