//
//  ViewWithFixedWidthViewContoller.swift
//  Cinema
//
//  Created by Alex on 9/28/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit

class ViewWithFixedWidthViewContoller: UIViewController {

    @IBOutlet private weak var scrollView: UIScrollView?
    @IBOutlet private var contentView: UIView!
    
    private var eqWidthConstraint: NSLayoutConstraint?
    private var eqHeightConstraint: NSLayoutConstraint?

    var isWidthLock: Bool = false {
        didSet {
            updateContent()
            eqWidthConstraint?.isActive = isWidthLock
        }
    }
    
    var isHeightLock: Bool = false {
        didSet {
            updateContent()
            eqHeightConstraint?.isActive = isHeightLock
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let scrollView = scrollView else { return }

        scrollView.keyboardDismissMode = .onDrag
        
        scrollView.contentSize = CGSize(width: contentView.bounds.width, height: contentView.bounds.size.height)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        eqWidthConstraint = NSLayoutConstraint(item: view,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: contentView,
                                         attribute: .width,
                                         multiplier: 1.0,
                                         constant: 1.0)
        
        eqHeightConstraint = NSLayoutConstraint(item: view,
                                                attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: contentView,
                                                 attribute: .height,
                                                 multiplier: 1.0,
                                                 constant: 1.0)


        let top = NSLayoutConstraint(item: scrollView,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: contentView,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: 1.0)

        top.isActive = true

        let left = NSLayoutConstraint(item: scrollView,
                                      attribute: .left,
                                      relatedBy: .equal,
                                      toItem: contentView,
                                      attribute: .left,
                                      multiplier: 1.0,
                                      constant: 1.0)
        left.isActive = true
        
        let right = NSLayoutConstraint(item: scrollView,
                                       attribute: .right,
                                       relatedBy: .equal,
                                       toItem: contentView,
                                       attribute: .right,
                                       multiplier: 1.0,
                                       constant: 1.0)

        right.isActive = true

        let bottom = NSLayoutConstraint(item: scrollView,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: contentView,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 1.0)
        bottom.isActive = true
        
    }
    
    func updateContent() {
        guard
            let currentContent = currentContent,
            let scrollView = scrollView
        else { return }

        scrollView.contentSize = CGSize(width: currentContent.bounds.width, height: currentContent.bounds.size.height)
    }
    
    
    weak var currentContent: UIView?
    
    func setContent(_ content: AtomPresenter) {
        guard let scrollView = scrollView else { return }
        
        let contentV = content.view
        currentContent = contentV
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentV.bounds.size.height)
        
        contentV.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentV)
        
        let top = NSLayoutConstraint(item: contentView,
                                     attribute: .top,
                                     relatedBy: .equal,
                                     toItem: contentV,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: 1.0)

        top.isActive = true

        let left = NSLayoutConstraint(item: contentView,
                                      attribute: .left,
                                      relatedBy: .equal,
                                      toItem: contentV,
                                      attribute: .left,
                                      multiplier: 1.0,
                                      constant: 1.0)
        left.isActive = true
        
        let right = NSLayoutConstraint(item: contentView,
                                       attribute: .right,
                                       relatedBy: .equal,
                                       toItem: contentV,
                                       attribute: .right,
                                       multiplier: 1.0,
                                       constant: 1.0)

        right.isActive = true

        let bottom = NSLayoutConstraint(item: contentView,
                                        attribute: .bottom,
                                        relatedBy: .equal,
                                        toItem: contentV,
                                        attribute: .bottom,
                                        multiplier: 1.0,
                                        constant: 1.0)
        bottom.isActive = true
    }

}

