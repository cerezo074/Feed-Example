//
//  MessageViewEvent.swift
//  Feed Test
//
//  Created by Eli Pacheco Hoyos on 8/01/20.
//  Copyright © 2020 test. All rights reserved.
//

import Foundation
import UIKit

class MessageViewEvent: NSObject {
    
    private unowned let eventHandler: PostViewInteraction
    
    init(eventHandler: PostViewInteraction) {
        self.eventHandler = eventHandler
    }
    
}

extension MessageViewEvent: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        eventHandler.update(message: textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)

        return updatedText.count <= eventHandler.messageLenght
    }
    
}
