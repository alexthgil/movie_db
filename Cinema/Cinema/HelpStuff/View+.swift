//
//  View+.swift
//  Cinema
//
//  Created by Alex on 10/12/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

extension UIView {
    
    func fill(by view: UIView) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        let top = NSLayoutConstraint(item: self,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: view,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: 1.0)

        top.isActive = true

        let left = NSLayoutConstraint(item: self,
                                      attribute: .left,
                                      relatedBy: .equal,
                                      toItem: view,
                                      attribute: .left,
                                      multiplier: 1.0,
                                      constant: 1.0)
        left.isActive = true

        let right = NSLayoutConstraint(item: self,
                                       attribute: .right,
                                       relatedBy: .equal,
                                       toItem: view,
                                       attribute: .right,
                                       multiplier: 1.0,
                                       constant: 1.0)

        right.isActive = true

        let bottom = NSLayoutConstraint(item: self,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: view,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 1.0)
        bottom.isActive = true
    }
}

