//
//  ViewController.swift
//  CoinEr
//
//  Created by OSX on 8/4/18.
//  Copyright © 2018 OSX. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var askBTCLabel: UILabel!
    @IBOutlet weak var bidBTCLabel: UILabel!
    @IBOutlet weak var askETHLabel: UILabel!
    @IBOutlet weak var bidETHLabel: UILabel!
    @IBOutlet weak var askXRPLabel: UILabel!
    @IBOutlet weak var bidXRPLabel: UILabel!
    
    
    
    @IBOutlet weak var usdButton: UIButton!
    @IBOutlet weak var eurButton: UIButton!
    @IBOutlet weak var dinButton: UIButton!
    
    let baseBTCURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let baseETHURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/ETH"
    let baseXRPURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/XRP"
    var finalBTCURL = ""
    var finalETHURL = ""
    var finalXRPURL = ""
    
    var selectedCurrency = ""
    var selectedSymbol = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.alpha = 0
        usdButton.roundCorners()
        eurButton.roundCorners()
        dinButton.roundCorners()
        animateStack(stack: stack)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateStack(stack: stack)
    }
    
    @IBAction func usdBtnPressed(_ sender: Any) {
        self.usdSelected()
        self.getAllData()
    }
    @IBAction func eurBtnPressed(_ sender: Any) {
        self.eurSelected()
        self.getAllData()
    }
    @IBAction func dinBtnPressed(_ sender: Any) {
        self.dinSelected()
        self.getAllData()
    }
    

 
    func fetchData(btcURL: String, ethURL: String, xrpURL: String){
        loadTheView(view: loadingView)
        Alamofire.request(btcURL, method: .get).responseJSON { (btcResponse) in
            if btcResponse.result.isSuccess {
                let btcJSON: JSON = JSON(btcResponse.result.value!)
                self.updateBTCui(json: btcJSON)
                loadComplete(view: self.loadingView)
            } else {
                debugPrint("ERR: \(String(describing: btcResponse.result.error?.localizedDescription))")
                self.askBTCLabel.text = "Error"
                loadComplete(view: self.loadingView)
                return
            }
        }
        Alamofire.request(ethURL, method: .get).responseJSON { (ethResponse) in
            if ethResponse.result.isSuccess {
                let ethJSON: JSON = JSON(ethResponse.result.value!)
                self.updateETHui(json: ethJSON)
            } else {
                debugPrint("ERR: \(String(describing: ethResponse.result.error?.localizedDescription))")
                self.askETHLabel.text = "Error"
                return
            }
        }
        Alamofire.request(xrpURL, method: .get).responseJSON { (xrpResponse) in
            if xrpResponse.result.isSuccess {
                let xrpJSON: JSON = JSON(xrpResponse.result.value!)
                self.updateXRPui(json: xrpJSON)
            } else {
                debugPrint("ERR: \(String(describing: xrpResponse.result.error?.localizedDescription))")
                self.askXRPLabel.text = "Error"
                return
            }
        }
        
    }
    
    
    func updateBTCui(json: JSON){
      if let btcAsk = json ["ask"].double, let btcBid = json ["bid"].double {
            askBTCLabel.text = selectedSymbol + " \(btcAsk)"
            bidBTCLabel.text = selectedSymbol + " \(btcBid)"
        } else {
            bidBTCLabel.text = "NO DATA."
            return
        }
    }
    
    func updateETHui(json: JSON){
        if let ethAsk = json ["ask"].double, let ethBid = json ["bid"].double {
            askETHLabel.text = selectedSymbol + " \(ethAsk)"
            bidETHLabel.text = selectedSymbol + " \(ethBid)"
        } else {
           return
        }
    }
    
    func updateXRPui(json: JSON){
        if let askXRP = json ["ask"].double, let bidXRP = json ["bid"].double {
            askXRPLabel.text = selectedSymbol + " \(askXRP)"
            bidXRPLabel.text = selectedSymbol + " \(bidXRP)"
        } else {
            return
        }
    }
    
   
    func usdSelected(){
        finalBTCURL = baseBTCURL + Currency.USD.rawValue
        finalETHURL = baseETHURL + Currency.USD.rawValue
        finalXRPURL = baseXRPURL + Currency.USD.rawValue
        selectedSymbol = Symbol.USD.rawValue
        usdButton.setSelected()
        eurButton.setDeselected()
        dinButton.setDeselected()
    }
    func eurSelected(){
        finalBTCURL = baseBTCURL + Currency.EUR.rawValue
        finalETHURL = baseETHURL + Currency.EUR.rawValue
        finalXRPURL = baseXRPURL + Currency.EUR.rawValue
        selectedSymbol = Symbol.EUR.rawValue
        usdButton.setDeselected()
        eurButton.setSelected()
        dinButton.setDeselected()
    }
    func dinSelected(){
        finalBTCURL = baseBTCURL + Currency.DIN.rawValue
        finalETHURL = baseETHURL + Currency.DIN.rawValue
        finalXRPURL = baseXRPURL + Currency.DIN.rawValue
        selectedSymbol = Symbol.DIN.rawValue
        usdButton.setDeselected()
        eurButton.setDeselected()
        dinButton.setSelected()
    }

    func getAllData(){
        fetchData(btcURL: finalBTCURL, ethURL: finalETHURL, xrpURL: finalXRPURL)
    }
    
}

