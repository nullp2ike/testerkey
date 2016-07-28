//
//  Contraints.swift
//  TesterKey
//
//  Created by Risko Ruus on 27/07/16.
//  Copyright © 2016 Risko Ruus. All rights reserved.
//
import UIKit

func addIndividualButtonConstraints(buttons: [UIButton], mainView: UIView){
    for (index, button) in buttons.enumerate() {
        
        let topConstraint = NSLayoutConstraint(item: button,
                                               attribute: .Top,
                                               relatedBy: .Equal,
                                               toItem: mainView,
                                               attribute: .Top,
                                               multiplier: 1.0,
                                               constant: 1)
        
        let bottomConstraint = NSLayoutConstraint(item: button,
                                                  attribute: .Bottom,
                                                  relatedBy: .Equal,
                                                  toItem: mainView,
                                                  attribute: .Bottom,
                                                  multiplier: 1.0,
                                                  constant: -1)
        
        var rightConstraint : NSLayoutConstraint!
        
        if index == buttons.count - 1 {
            
            rightConstraint = NSLayoutConstraint(item: button,
                                                 attribute: .Right,
                                                 relatedBy: .Equal,
                                                 toItem: mainView,
                                                 attribute: .Right,
                                                 multiplier: 1.0,
                                                 constant: -1)
            
        }else{
            
            let nextButton = buttons[index+1]
            rightConstraint = NSLayoutConstraint(item: button,
                                                 attribute: .Right,
                                                 relatedBy: .Equal,
                                                 toItem: nextButton,
                                                 attribute: .Left,
                                                 multiplier: 1.0,
                                                 constant: -1)
        }
        
        
        var leftConstraint : NSLayoutConstraint!
        
        if index == 0 {
            
            leftConstraint = NSLayoutConstraint(item: button,
                                                attribute: .Left,
                                                relatedBy: .Equal,
                                                toItem: mainView,
                                                attribute: .Left,
                                                multiplier: 1.0,
                                                constant: 1)
            
        }else{
            
            let prevtButton = buttons[index-1]
            leftConstraint = NSLayoutConstraint(item: button,
                                                attribute: .Left,
                                                relatedBy: .Equal,
                                                toItem: prevtButton,
                                                attribute: .Right,
                                                multiplier: 1.0,
                                                constant: 1)
            
            let firstButton = buttons[0]
            let widthConstraint = NSLayoutConstraint(item: firstButton,
                                                     attribute: .Width,
                                                     relatedBy: .Equal,
                                                     toItem: button,
                                                     attribute: .Width,
                                                     multiplier: 1.0,
                                                     constant: 0)
            
            widthConstraint.priority = 995
            mainView.addConstraint(widthConstraint)
        }
        NSLayoutConstraint.activateConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
    }
}

func addConstraintsToInputView(inputView: UIView, rowViews: [UIView]){
    for (index, rowView) in rowViews.enumerate() {
        let rightSideConstraint = NSLayoutConstraint(item: rowView,
                                                     attribute: .Right,
                                                     relatedBy: .Equal,
                                                     toItem: inputView,
                                                     attribute: .Right,
                                                     multiplier: 1.0,
                                                     constant: -1)
        let leftConstraint = NSLayoutConstraint(item: rowView,
                                                attribute: .Left,
                                                relatedBy: .Equal,
                                                toItem: inputView,
                                                attribute: .Left, multiplier: 1.0, constant: 1)
        NSLayoutConstraint.activateConstraints([leftConstraint, rightSideConstraint])
        var topConstraint: NSLayoutConstraint
        if index == 0 {
            topConstraint = NSLayoutConstraint(item: rowView,
                                               attribute: .Top,
                                               relatedBy: .Equal,
                                               toItem: inputView,
                                               attribute: .Top,
                                               multiplier: 1.0,
                                               constant: 0)
            
        }else{
            
            let prevRow = rowViews[index-1]
            topConstraint = NSLayoutConstraint(item: rowView,
                                               attribute: .Top,
                                               relatedBy: .Equal,
                                               toItem: prevRow,
                                               attribute: .Bottom,
                                               multiplier: 1.0,
                                               constant: 0)
            let firstRow = rowViews[0]
            let heightConstraint = NSLayoutConstraint(item: firstRow,
                                                      attribute: .Height,
                                                      relatedBy: .Equal,
                                                      toItem: rowView,
                                                      attribute: .Height,
                                                      multiplier: 1.0,
                                                      constant: 0)
            heightConstraint.priority = 995
            NSLayoutConstraint.activateConstraints([heightConstraint])
        }
        NSLayoutConstraint.activateConstraints([topConstraint])
        var bottomConstraint: NSLayoutConstraint
        if index == rowViews.count - 1 {
            bottomConstraint = NSLayoutConstraint(item: rowView,
                                                  attribute: .Bottom,
                                                  relatedBy: .Equal,
                                                  toItem: inputView,
                                                  attribute: .Bottom,
                                                  multiplier: 1.0,
                                                  constant: 0)
            NSLayoutConstraint.activateConstraints([bottomConstraint])
        }else{
            let nextRow = rowViews[index+1]
            bottomConstraint = NSLayoutConstraint(item: rowView,
                                                  attribute: .Bottom,
                                                  relatedBy: .Equal,
                                                  toItem: nextRow,
                                                  attribute: .Top,
                                                  multiplier: 1.0,
                                                  constant: 0)
            NSLayoutConstraint.activateConstraints([bottomConstraint])
        }
    }
}
