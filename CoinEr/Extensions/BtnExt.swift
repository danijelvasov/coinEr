//
//  BtnExt.swift
//  CoinEr
//
//  Created by OSX on 8/4/18.
//  Copyright © 2018 OSX. All rights reserved.
//

import UIKit

extension UIButton {
    func setSelected(){
        self.layer.backgroundColor = #colorLiteral(red: 0.1804309467, green: 0.6971565673, blue: 0.5437385027, alpha: 1)
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControlState.normal)
        
    }
    
    func setDeselected(){
        self.layer.backgroundColor = #colorLiteral(red: 0.7859020201, green: 1, blue: 0.8379783839, alpha: 0.5)
        self.setTitleColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1), for: UIControlState.normal)
    }
    
    func roundCorners(){
        self.layer.cornerRadius = 14
    }
    
}
