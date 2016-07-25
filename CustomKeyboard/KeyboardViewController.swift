//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by Risko Ruus on 19/07/16.
//  Copyright © 2016 Risko Ruus. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    //iPhone 4S 320x480
    //iPhone 6S 375x667?
    
    var heightConstraint: NSLayoutConstraint!
    
    let rowHeight : CGFloat = 40.0
    var label :UILabel = UILabel()
    var functionKeyValues = [String: String]()
    var variablesFromHostApp = NSUserDefaults(suiteName: "group.eu.testandrest.TesterKey")
    
    var defaultViewHidden = false
    
    var row1 = UIView()
    var row2 = UIView()
    var row3 = UIView()
    var row4 = UIView()
    
    var row1_ = UIView()
    var row2_ = UIView()
    var row3_ = UIView()
    var row4_ = UIView()
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        variablesFromHostApp?.synchronize() //Probably not needed, but just in case
        defaultViewHidden = false
        
        row1 = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, rowHeight))
        row1.addSubview(addKeyboardLabel())
        
        let buttonTitlesRow2 = ["F1", "F2", "F3", "F4", "F5", "F6"]
        let buttonTitlesRow3 = ["CS", "W", "Lorem", "XSS", "SQL", "ABC"]
        let buttonTitlesRow4 = ["Hide","KB", "Copy", "Clear", "<"]
        
        row2 = createRowOfButtons(buttonTitlesRow2)
        row3 = createRowOfButtons(buttonTitlesRow3)
        row4 = createRowOfButtons(buttonTitlesRow4)
        
        self.view.addSubview(row1)
        self.view.addSubview(row2)
        self.view.addSubview(row3)
        self.view.addSubview(row4)
        
        row1.translatesAutoresizingMaskIntoConstraints = false
        row2.translatesAutoresizingMaskIntoConstraints = false
        row3.translatesAutoresizingMaskIntoConstraints = false
        row4.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintsToInputView(self.view, rowViews: [row1, row2, row3, row4])
        
        csView()
    }
    
    func csView(){
        let buttonTitlesRow2 = ["1", "2", "3", "4", "5"]
        let buttonTitlesRow3 = ["6","7", "8", "9", "0"]
        let buttonTitlesRow4 = ["Back", "Submit", "Clear", "<"]
        
        
        row1_ = addKeyboardLabel()
        row2_ = createRowOfButtons(buttonTitlesRow2)
        row3_ = createRowOfButtons(buttonTitlesRow3)
        row4_ = createRowOfButtons(buttonTitlesRow4)
        
        row1_.hidden = true
        row2_.hidden = true
        row3_.hidden = true
        row4_.hidden = true
        
        self.view.addSubview(row1_)
        self.view.addSubview(row2_)
        self.view.addSubview(row3_)
        self.view.addSubview(row4_)
        
        row1_.translatesAutoresizingMaskIntoConstraints = false
        row2_.translatesAutoresizingMaskIntoConstraints = false
        row3_.translatesAutoresizingMaskIntoConstraints = false
        row4_.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintsToInputView(self.view, rowViews: [row1_, row2_, row3_, row4_])
        
    }

    
    func hideDefaultView(){
        
        defaultViewHidden = true
        
        row1.hidden = true
        row2.hidden = true
        row3.hidden = true
        row4.hidden = true
        
        row1_.hidden = false
        row2_.hidden = false
        row3_.hidden = false
        row4_.hidden = false
        
    }
    
    func showDefaultView(){
        defaultViewHidden = false
        
        row1.hidden = false
        row2.hidden = false
        row3.hidden = false
        row4.hidden = false
        
        row1_.hidden = true
        row2_.hidden = true
        row3_.hidden = true
        row4_.hidden = true
        
    }
    
    func createRowOfButtons(buttonTitles: [NSString]) -> UIView {
        var buttons = [UIButton]()
        let keyboardRowView = UIView(frame: CGRectMake(0, 0, 320, rowHeight))
        
        for buttonTitle in buttonTitles{
            
            let button = createButtonWithTitle(buttonTitle as String)
            buttons.append(button)
            keyboardRowView.addSubview(button)
        }
        
        addIndividualButtonConstraints(buttons, mainView: keyboardRowView)
        
        return keyboardRowView
    }
    
    func createButtonWithTitle(title: String) -> UIButton {
        
        let button = UIButton()
        button.frame = CGRectMake(0, 0, 15, 15)
        button.setTitle(title, forState: .Normal)
        button.sizeToFit()
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        button.addTarget(self, action: #selector(keyPressed), forControlEvents: .TouchUpInside)
        
        return button
    }
    
    func addIndividualButtonConstraints(buttons: [UIButton], mainView: UIView){
        
        for (index, button) in buttons.enumerate() {
            
            let topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: mainView, attribute: .Top, multiplier: 1.0, constant: 1)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: mainView, attribute: .Bottom, multiplier: 1.0, constant: -1)
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == buttons.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: mainView, attribute: .Right, multiplier: 1.0, constant: -1)
                
            }else{
                
                let nextButton = buttons[index+1]
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: nextButton, attribute: .Left, multiplier: 1.0, constant: -1)
            }
            
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: mainView, attribute: .Left, multiplier: 1.0, constant: 1)
                
            }else{
                
                let prevtButton = buttons[index-1]
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: prevtButton, attribute: .Right, multiplier: 1.0, constant: 1)
                
                let firstButton = buttons[0]
                let widthConstraint = NSLayoutConstraint(item: firstButton, attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 1.0, constant: 0)
                
                widthConstraint.priority = 800
                mainView.addConstraint(widthConstraint)
            }
            
            mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
    }

    func addConstraintsToInputView(inputView: UIView, rowViews: [UIView]){
        
        for (index, rowView) in rowViews.enumerate() {
            let rightSideConstraint = NSLayoutConstraint(item: rowView, attribute: .Right, relatedBy: .Equal, toItem: inputView, attribute: .Right, multiplier: 1.0, constant: -1)
            
            let leftConstraint = NSLayoutConstraint(item: rowView, attribute: .Left, relatedBy: .Equal, toItem: inputView, attribute: .Left, multiplier: 1.0, constant: 1)
            
            inputView.addConstraints([leftConstraint, rightSideConstraint])
            
            var topConstraint: NSLayoutConstraint
            
            if index == 0 {
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .Top, relatedBy: .Equal, toItem: inputView, attribute: .Top, multiplier: 1.0, constant: 0)
                
            }else{
                
                let prevRow = rowViews[index-1]
                topConstraint = NSLayoutConstraint(item: rowView, attribute: .Top, relatedBy: .Equal, toItem: prevRow, attribute: .Bottom, multiplier: 1.0, constant: 0)
                
                let firstRow = rowViews[0]
                let heightConstraint = NSLayoutConstraint(item: firstRow, attribute: .Height, relatedBy: .Equal, toItem: rowView, attribute: .Height, multiplier: 1.0, constant: 0)
                
                heightConstraint.priority = 800
                inputView.addConstraint(heightConstraint)
            }
            inputView.addConstraint(topConstraint)
            
            var bottomConstraint: NSLayoutConstraint
            
            if index == rowViews.count - 1 {
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .Bottom, relatedBy: .Equal, toItem: inputView, attribute: .Bottom, multiplier: 1.0, constant: 0)
                
            }else{
                
                let nextRow = rowViews[index+1]
                bottomConstraint = NSLayoutConstraint(item: rowView, attribute: .Bottom, relatedBy: .Equal, toItem: nextRow, attribute: .Top, multiplier: 1.0, constant: 0)
            }
            
            inputView.addConstraint(bottomConstraint)
        }
        
    }
    
    
    func addKeyboardLabel() -> UILabel{
        label = UILabel(frame: CGRectMake(0, 0, 320, rowHeight))
        label.textAlignment = NSTextAlignment.Center
        label.text = "TesterKey!"
        return label
    }
    
    var currentTestKey = "" //Var for storing, which special test key function has been pressed CS, W etc.
    
    func keyPressed(sender: AnyObject?) {
        let numbers = ["1","2","3","4","5","6","7","8","9","0"]
        let button = sender as! UIButton
        let title = button.titleForState(.Normal)
        if(title == "KB"){
            advanceToNextInputMode()
        }
        else if(title == "CS"){
            currentTestKey = "CS"
            label.text = ""
            hideDefaultView()
        }
        else if(title == "W"){
            currentTestKey = "W"
            label.text = ""
            hideDefaultView()
        }
        else if(title == "Back"){
            showDefaultView()
        }
        else if(numbers.contains(title!)){
            label.text = label.text! + title!
            
        }
        else if (title == "@"){
            (textDocumentProxy as UIKeyInput).insertText("rsiqam@gmail.com")
        }
        else if(title == "Copy"){
            if(defaultViewHidden == true){
                UIPasteboard.generalPasteboard().string = label.text
            }else{
                UIPasteboard.generalPasteboard().string = textDocumentProxy.documentContextBeforeInput
            }
            hideDefaultView()
            
        }
        else if(title == "<"){
            if(defaultViewHidden == true){
                let oldLabelText = label.text
                let newLabelText = String(oldLabelText!.characters.dropLast())
                label.text = newLabelText
            }else{
                (textDocumentProxy as UIKeyInput).deleteBackward()
            }
            
        }
        else if(title == "Clear"){
            if(defaultViewHidden == true){
                label.text = ""
                print("Clear1")
            }else{
                print("Clear2")
                let previousTextLength = textDocumentProxy.documentContextBeforeInput?.characters.count;
                if(previousTextLength > 0){
                    for _ in 1 ... Int(previousTextLength!){
                        (textDocumentProxy as UIKeyInput).deleteBackward()
                    }
                }
            }
            
        }
        else if(title == "Hide"){
            dismissKeyboard()
        }
        else if(title == "Submit"){
            var textToInsert = ""
            if(currentTestKey == "CS" && Int(label.text!) > 0){
                let utils = Utils()
                textToInsert = utils.counterString(Int(label.text!)!,posMarker: "x")
            }else if (currentTestKey == "W" && Int(label.text!) > 0){
                textToInsert = String(count: Int(label.text!)!, repeatedValue: ("W" as Character))
            }
            
            (textDocumentProxy as UIKeyInput).insertText(textToInsert)
            showDefaultView()
            currentTestKey = ""

        }
        else if(title == "F1"){
            let restoredValue = variablesFromHostApp!.stringForKey("F1")
            (textDocumentProxy as UIKeyInput).insertText(restoredValue!)
        }
        else{
            (textDocumentProxy as UIKeyInput).insertText(title!)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
            textColor = UIColor.whiteColor()
        } else {
            textColor = UIColor.blackColor()
        }
    }
    
}
