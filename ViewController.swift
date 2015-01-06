//
//  ViewController.swift
//  LemonadeStand
//
//  Created by The Pez on 1/3/15.
//  Copyright (c) 2015 WigWagWorkshop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var moneySupplyCount: UILabel!
    @IBOutlet weak var lemonSupplyCount: UILabel!
    @IBOutlet weak var iceCubeSupplyCount: UILabel!
    
    @IBOutlet weak var lemonPurchaseCount: UILabel!
    @IBOutlet weak var iceCubePurchaseCount: UILabel!
    
    @IBOutlet weak var lemonMixCount: UILabel!
    @IBOutlet weak var iceCubeMixCount: UILabel!
    
    var supplies = Supplies(aMoney: 10, aLemons: 1, aIceCubes: 1)
    var price = Price()
    
    var lemonsToPurchase = 0
    var iceCubesToPurchase = 0
    var lemonsToMix = 0
    var iceCubesToMix = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateMainView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func purchaseLemonButtonPressed(sender: AnyObject) {
        if supplies.money >= price.lemon {
            lemonsToPurchase += 1
            supplies.money -= price.lemon
            supplies.lemons += 1
        }
        else {
            showAlertWithText(message: "You Don't Have Enough Money")
        }
        updateMainView()
    }
    
    @IBAction func purchaseIceCubeButtonPressed(sender: AnyObject) {
        if supplies.money >= price.iceCube {
            iceCubesToPurchase += 1
            supplies.money -= price.iceCube
            supplies.iceCubes += 1
        }
        else {
            showAlertWithText(header: "Error", message: "You Don't Have Enough Money")
        }
        updateMainView()
    }
    
    @IBAction func unpurchasedLemonButtonPressed(sender: AnyObject) {
        if lemonsToPurchase > 0 {
            lemonsToPurchase -= 1
            supplies.money += price.lemon
            supplies.lemons -= 1
        }
        else {
            showAlertWithText(message: "You Don't Have Anything To Return")
        }
        updateMainView()

    }
    
    @IBAction func unpurchasedIceCubeButtonPressed(sender: AnyObject) {
        if iceCubesToPurchase > 0 {
            iceCubesToPurchase -= 1
            supplies.money += price.iceCube
            supplies.iceCubes -= 1
        }
        else {
            showAlertWithText(message: "You Don't Have Anything To Return")
        }
        updateMainView()

    }

    @IBAction func mixLemonButtonPressed(sender: AnyObject) {
        if supplies.lemons > 0 {
            supplies.lemons -= 1
            lemonsToMix += 1
        }
        else {
            showAlertWithText(message: "You Don't Have Enough Inventory")
        }
        updateMainView()
    }
    
    @IBAction func mixIceCubeButtonPressed(sender: AnyObject) {
        if supplies.iceCubes > 0 {
            supplies.iceCubes -= 1
            iceCubesToMix += 1
        }
        else {
            showAlertWithText(message: "You Don't Have Enough Inventory")
        }
        updateMainView()
    }
    
    @IBAction func unmixLemonButtonPressed(sender: AnyObject) {
        if lemonsToMix > 0 {
            lemonsToMix -= 1
            supplies.lemons += 1
        }
        else {
            showAlertWithText(message: "You Have Nothing To Un-Mix")
        }
        updateMainView()
    
    }
    
    @IBAction func unmixIceCubeButtonPressed(sender: AnyObject) {
        if iceCubesToMix > 0 {
            iceCubesToMix -= 1
            supplies.iceCubes += 1
        }
        else {
            showAlertWithText(message: "You Have Nothing To Un-Mix")
        }
        updateMainView()
    }
    
    @IBAction func startDayButtonPressed(sender: AnyObject) {
        
        let customers = Int(arc4random_uniform(UInt32(11)))
        println("customers \(customers)")
        
        let lemonadeRatio = Float(lemonsToMix) / Float(iceCubesToMix)
        println("Lemonade Ratio: \(lemonadeRatio)")
        
        for x in 0...customers {
            
            let preferance = Double(arc4random_uniform(UInt32(100))) / 100
            
            if preferance < 0.4 && lemonadeRatio > 1 {
                supplies.money += 1
                println("Paid")
            }
            else if preferance > 0.6 && lemonadeRatio < 1 {
                supplies.money += 1
                println("Paid")
            }
            else if preferance <= 0.6 && preferance >= 0.4 && lemonadeRatio == 1 {
                supplies.money += 1
                println("Paid")
            }
            else {
                println("No Match, No Revenue")
            }
        }
        
    }
    
    func updateMainView() {
        moneySupplyCount.text = "$\(supplies.money)"
        lemonSupplyCount.text = "\(supplies.lemons) Lemons"
        iceCubeSupplyCount.text = "\(supplies.iceCubes) Ice Cubes"
        
        lemonPurchaseCount.text = "\(lemonsToPurchase)"
        iceCubePurchaseCount.text = "\(iceCubesToPurchase)"
        
        lemonMixCount.text = "\(lemonsToMix)"
        iceCubeMixCount.text = "\(iceCubesToMix)"
    }
    
    func showAlertWithText (header: String = "Warning", message: String) {
       var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    


}

