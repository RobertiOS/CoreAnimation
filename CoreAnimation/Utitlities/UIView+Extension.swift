//
//  UIView+Extension.swift
//  CoreAnimation
//
//  Created by Roberto Corrales on 5/27/24.
//

import UIKit

extension UIView {
    func constraint(for attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let directConstraint = self.constraints.first(where: { $0.firstAttribute == attribute && $0.firstItem as? UIView == self }) {
            return directConstraint
        }

        return self.superview?.constraints.first(where: {
            ($0.firstAttribute == attribute && $0.firstItem as? UIView == self) ||
            ($0.secondAttribute == attribute && $0.secondItem as? UIView == self)
        })
    }
}
