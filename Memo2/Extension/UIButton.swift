//
//  UIButton.swift
//  Memo2
//
//  Created by 박유경 on 2023/08/22.
//

import UIKit

extension UIButton {
    func setupCustomButtonUI(){
        self.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 0.5, alpha: 1.0)
        self.setTitleColor(.blue, for: .normal)
        self.layer.cornerRadius = 10.0
    }
    func setupCustomMoveButtonUI(){
        self.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 1.0, alpha: 1.0)
        self.setTitleColor(.blue, for: .normal)
        self.layer.cornerRadius = 10.0
    }
    
    func setupCustomButtonFont(){
        let buttonFont = UIFont(name: "Helvetica-Bold", size: 17.0)
        self.titleLabel?.font = buttonFont
        self.setTitleColor(.white, for: .normal)
        
    }
    
}
