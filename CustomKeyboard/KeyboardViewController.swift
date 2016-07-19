//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by Risko Ruus on 19/07/16.
//  Copyright © 2016 Risko Ruus. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var heightConstraint: NSLayoutConstraint!
    let keyboardHeight : CGFloat = 160
    let keyBoardWidth : CGFloat = 320
    let rowHeight : CGFloat = 40
    var label :UILabel = UILabel()
    var defaultView = UIView()
    var csView = UIView()
    var functionKeyValues = [String: String]()
    var variablesFromHostApp = NSUserDefaults(suiteName: "group.eu.testandrest.TesterKey")
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        variablesFromHostApp?.synchronize() //Probably not needed, but just in case
        
        defaultView = UIView(frame: CGRectMake(0, 0, keyBoardWidth, keyboardHeight))
        
        let row1 = UIView(frame: CGRectMake(0, 0, keyBoardWidth, rowHeight))
        row1.addSubview(addKeyboardLabel())
        
        let buttonTitlesRow2 = ["F1", "F2", "F3", "F4", "F5", "F6"]
        let buttonTitlesRow3 = ["CS", "W", "Lorem", "XSS", "SQL", "ABC"]
        let buttonTitlesRow4 = ["Hide","KB", "Copy", "Clear", "<"]
        
        let buttonsRow2 = createButtons(buttonTitlesRow2)
        let buttonsRow3 = createButtons(buttonTitlesRow3)
        let buttonsRow4 = createButtons(buttonTitlesRow4)
        
        let row2 = UIView(frame: CGRectMake(0, rowHeight, keyBoardWidth, rowHeight))
        let row3 = UIView(frame: CGRectMake(0, rowHeight * 2, keyBoardWidth, rowHeight))
        let row4 = UIView(frame: CGRectMake(0, rowHeight * 3, keyBoardWidth, rowHeight))
        
        for button in buttonsRow2 {
            row2.addSubview(button)
        }
        
        for button in buttonsRow3 {
            row3.addSubview(button)
        }
        
        for button in buttonsRow4 {
            row4.addSubview(button)
        }
        
        defaultView.addSubview(row1)
        defaultView.addSubview(row2)
        defaultView.addSubview(row3)
        defaultView.addSubview(row4)
        
        self.view.addSubview(defaultView)
        
        addConstraints(buttonsRow2, containingView: row2)
        addConstraints(buttonsRow3, containingView: row3)
        addConstraints(buttonsRow4, containingView: row4)
        
        //This makes keyboard height lower, what we desire
        self.heightConstraint = NSLayoutConstraint(
            item:self.inputView!,
            attribute:.Height,
            relatedBy:.Equal,
            toItem:nil,
            attribute:.NotAnAttribute,
            multiplier:0.0,
            constant:keyboardHeight)
        addCSView()
        
    }
    
    //This is currently needed to apply the heightConstraint
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.inputView!.addConstraint(self.heightConstraint)
    }
    
    func addCSView(){
        csView = UIView(frame: CGRectMake(0, 0, keyBoardWidth, keyboardHeight))
        
        let row1 = UIView(frame: CGRectMake(0, 0, keyBoardWidth, rowHeight))
        row1.addSubview(addKeyboardLabel())
        
        let buttonTitlesRow2 = ["1", "2", "3", "4", "5"]
        let buttonsRow2 = createButtons(buttonTitlesRow2)
        let row2 = UIView(frame: CGRectMake(0, rowHeight, keyBoardWidth, rowHeight))
        
        let buttonTitlesRow3 = ["6","7", "8", "9", "0"]
        let buttonsRow3 = createButtons(buttonTitlesRow3)
        let row3 = UIView(frame: CGRectMake(0, rowHeight * 2, keyBoardWidth, rowHeight))
        
        let buttonTitlesRow4 = ["Back", "Submit", "Clear", "<"]
        let buttonsRow4 = createButtons(buttonTitlesRow4)
        let row4 = UIView(frame: CGRectMake(0, rowHeight * 3, keyBoardWidth, rowHeight))
        
        for button in buttonsRow2 {
            row2.addSubview(button)
        }
        
        for button in buttonsRow3 {
            row3.addSubview(button)
        }
        
        for button in buttonsRow4 {
            row4.addSubview(button)
        }
        
        csView.addSubview(row1)
        csView.addSubview(row2)
        csView.addSubview(row3)
        csView.addSubview(row4)
        
        csView.hidden = true
        
        self.view.addSubview(csView)
        
        addConstraints(buttonsRow2, containingView: row2)
        addConstraints(buttonsRow3, containingView: row3)
        addConstraints(buttonsRow4, containingView: row4)
    }
    
    func addKeyboardLabel() -> UILabel{
        label = UILabel(frame: CGRectMake(0, 0, keyBoardWidth, rowHeight))
        label.textAlignment = NSTextAlignment.Center
        label.text = "TesterKey!"
        return label
    }
    
    func addConstraints(buttons: [UIButton], containingView: UIView){
        for (index, button) in buttons.enumerate() {
            
            let topConstraint = NSLayoutConstraint(item: button, attribute: .Top, relatedBy: .Equal, toItem: containingView, attribute: .Top, multiplier: 1.0, constant: 1)
            
            let bottomConstraint = NSLayoutConstraint(item: button, attribute: .Bottom, relatedBy: .Equal, toItem: containingView, attribute: .Bottom, multiplier: 1.0, constant: -1)
            
            var leftConstraint : NSLayoutConstraint!
            
            if index == 0 {
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: containingView, attribute: .Left, multiplier: 1.0, constant: 1)
                
            }else{
                
                leftConstraint = NSLayoutConstraint(item: button, attribute: .Left, relatedBy: .Equal, toItem: buttons[index-1], attribute: .Right, multiplier: 1.0, constant: 1)
                
                let widthConstraint = NSLayoutConstraint(item: buttons[0], attribute: .Width, relatedBy: .Equal, toItem: button, attribute: .Width, multiplier: 1.0, constant: 0)
                
                containingView.addConstraint(widthConstraint)
            }
            
            var rightConstraint : NSLayoutConstraint!
            
            if index == buttons.count - 1 {
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: containingView, attribute: .Right, multiplier: 1.0, constant: -1)
                
            }else{
                
                rightConstraint = NSLayoutConstraint(item: button, attribute: .Right, relatedBy: .Equal, toItem: buttons[index+1], attribute: .Left, multiplier: 1.0, constant: -1)
            }
            
            containingView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
        }
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
            defaultView.hidden = true
            csView.hidden = false
        }
        else if(title == "W"){
            currentTestKey = "W"
            label.text = ""
            defaultView.hidden = true
            csView.hidden = false
        }
        else if(title == "Back"){
            csView.hidden = true
            defaultView.hidden = false
        }
        else if(numbers.contains(title!)){
            label.text = label.text! + title!
            
        }
        else if (title == "@"){
            (textDocumentProxy as UIKeyInput).insertText("rsiqam@gmail.com")
        }
        else if(title == "Copy"){
            if(defaultView.hidden == true){
                UIPasteboard.generalPasteboard().string = label.text
            }else{
                UIPasteboard.generalPasteboard().string = textDocumentProxy.documentContextBeforeInput
            }
            
        }
        else if(title == "<"){
            if(defaultView.hidden == true){
                let oldLabelText = label.text
                let newLabelText = String(oldLabelText!.characters.dropLast())
                label.text = newLabelText
            }else{
                (textDocumentProxy as UIKeyInput).deleteBackward()
            }
            
        }
        else if(title == "Clear"){
            if(defaultView.hidden == true){
                label.text = ""
            }else{
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
            defaultView.hidden = false
            csView.hidden = true
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
    
    
    func createButtons(titles: [String]) -> [UIButton] {
        
        var buttons = [UIButton]()
        
        for title in titles {
            let button = UIButton()
            button.setTitle(title, forState: .Normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
            button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
            button.addTarget(self, action: #selector(keyPressed), forControlEvents: .TouchUpInside)
            buttons.append(button)
        }
        return buttons
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
