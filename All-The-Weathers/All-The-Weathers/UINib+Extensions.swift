//  UINib+Extensions.swift
//  All-The-Weathers
//  Created by Peter Foti on 10/19/15.
//  Copyright © 2015 Peter Foti. All rights reserved.

import UIKit

extension UINib {
    convenience init!(nibName: NibNames) {
        self.init(nibName: nibName.rawValue, bundle: nil)
    }
}
