//
//  AppDelegate.swift
//  Banking sys
//
//  Created by Gayathri V on 22/07/21.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
       
        print("Enter the ATM Branch : ")
        let atmBranch = readLine()
        let atm = ATM(id: 1, atmLocation: atmBranch ?? "")
        print("Welcome to \(atm.atmLocation) branch ATM of HDFC Bank \n")
        let operation = Operation()
        operation.startCustomerService()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}
