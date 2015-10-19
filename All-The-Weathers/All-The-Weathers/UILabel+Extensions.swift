//  UILabel+Extensions.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import UIKit

extension UILabel {
    func animateTextUpdate(text: String, animationDuration: NSTimeInterval) {
        UIView.transitionWithView(self, duration: animationDuration, options: .TransitionCrossDissolve, animations: { () -> Void in
            self.text = text
            }, completion: nil)
    }
}
