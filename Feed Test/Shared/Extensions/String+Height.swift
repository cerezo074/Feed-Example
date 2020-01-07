//
//  String+Height.swift
//  Feed Test
//
//  Created by Eli Pacheco Hoyos on 7/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func height(constraintedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let label =  UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.text = self
        label.font = font
        label.sizeToFit()
        
        return label.frame.height
    }
    
}
