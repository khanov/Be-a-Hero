//
//  Helpers.swift
//  Be a Hero
//
//  Created by Salavat Khanov on 3/14/15.
//  Copyright (c) 2015 Arty Technology. All rights reserved.
//

import UIKit

extension Kingdom {
    var image: UIImage? {
        if imageData.length > 0 {
            return UIImage(data: imageData)
        }
        return nil
    }
}

extension Giver {
    var image: UIImage? {
        if imageData.length > 0 {
            return UIImage(data: imageData)
        }
        return nil
    }
}

extension String {
    var containsEmailAddress: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest?.evaluateWithObject(self) ?? false
    }
}

