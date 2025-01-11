//
//  File.swift
//  
//
//  Created by İbrahim Taşdemir on 11.01.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            self.addSubview($0)
        }
    }
}
