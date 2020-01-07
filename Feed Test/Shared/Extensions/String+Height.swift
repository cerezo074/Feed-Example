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
        let attributedText = NSAttributedString(string: (self as NSString) as String, attributes: [NSAttributedString.Key.font: font])
        let textStorage = NSTextStorage(attributedString: attributedText)
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingRect = CGRect(origin: .zero, size: size)

        let textContainer = NSTextContainer(size: size)
        textContainer.lineFragmentPadding = 0

        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)

        textStorage.addLayoutManager(layoutManager)

        layoutManager.glyphRange(forBoundingRect: boundingRect, in: textContainer)

        let rect = layoutManager.usedRect(for: textContainer)

        return rect.integral.size.height
    }
    
}
