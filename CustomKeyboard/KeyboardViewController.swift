//
//  KeyboardViewController.swift
//  CustomKeyboard
//
//  Created by Risko Ruus on 19/07/16.
//  Copyright © 2016 Risko Ruus. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var currentTestKey = "" //Var for storing, which special test key function has been pressed CS, W etc.
    
    let rowHeight : CGFloat = 40.0
    var label :UILabel = UILabel()
    var functionKeyValues = [String: String]()
    var variablesFromHostApp = NSUserDefaults(suiteName: "group.eu.testandrest.TesterKey")
    
    var defaultViewHidden = false
    
    var row1 = UIView()
    var row2 = UIView()
    var row3 = UIView()
    var row4 = UIView()
    
    var row1CS = UIView()
    var row2CS = UIView()
    var row3CS = UIView()
    var row4CS = UIView()
    
    var buttonTitlesRow2 = ["F1", "F2", "F3", "FN", "LN", "ABC", "URL"]
    var buttonTitlesRow3 = ["CS", "W", "Lorem", "?", "@", "#", "Date", "XSS"]
    var buttonTitlesRow4 = ["Hide","\u{1F310}", "\u{2423}","Copy", "Clear", "\u{232B}", "\u{23CE}"]

    let buttonTitlesRow2CS = ["1", "2", "3", "4", "5"]
    let buttonTitlesRow3CS = ["6","7", "8", "9", "0"]
    let buttonTitlesRow4CS = ["Back", "Clear", "\u{232B}","\u{23CE}"]
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(Lorem.date)
//        print(Lorem.firstName)
//        print(Lorem.name)
//        print(Lorem.paragraph)
//        print(Lorem.paragraphs(2))
//        print(Lorem.sentence)
//        print(Lorem.sentences(2))
//        print(Lorem.title)
//        print(Lorem.URL)
//        print(Lorem.word)
//        print(Lorem.words(2))
        
        let width = UIScreen.mainScreen().bounds.width

        variablesFromHostApp?.synchronize() //Probably not needed, but just in case
        
        label = UILabel(frame: CGRectMake(0, 0, 320, rowHeight))
        label.textAlignment = NSTextAlignment.Center
        label.text = "TesterKey!"
        label.textColor = UIColor.blackColor()
        
        row1 = UIView(frame: CGRectMake(0, 0, width, rowHeight))
        row1.addSubview(label)
        row2 = createRowOfButtons(buttonTitlesRow2)
        row3 = createRowOfButtons(buttonTitlesRow3)
        row4 = createRowOfButtons(buttonTitlesRow4)
        
        
        row1CS = UIView(frame: CGRectMake(0, 0, width, rowHeight))
        row1CS.addSubview(label)
        row2CS = createRowOfButtons(buttonTitlesRow2CS)
        row3CS = createRowOfButtons(buttonTitlesRow3CS)
        row4CS = createRowOfButtons(buttonTitlesRow4CS)
        
        if(defaultViewHidden){
            hideDefaultView()
        }else{
            showDefaultView()
        }
    
    }
    
    
    func hideDefaultView(){
        defaultViewHidden = true
        
        row1.hidden = true
        row2.hidden = true
        row3.hidden = true
        row4.hidden = true
        
        row1CS.hidden = false
        row2CS.hidden = false
        row3CS.hidden = false
        row4CS.hidden = false
        
        row1CS.translatesAutoresizingMaskIntoConstraints = false
        row2CS.translatesAutoresizingMaskIntoConstraints = false
        row3CS.translatesAutoresizingMaskIntoConstraints = false
        row4CS.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(row1CS)
        self.view.addSubview(row2CS)
        self.view.addSubview(row3CS)
        self.view.addSubview(row4CS)
        
        addConstraintsToInputView(self.view, rowViews: [row1CS, row2CS, row3CS, row4CS])
        
    }
    
    func showDefaultView(){
        defaultViewHidden = false
        
        row1.hidden = false
        row2.hidden = false
        row3.hidden = false
        row4.hidden = false
        
        row1CS.hidden = true
        row2CS.hidden = true
        row3CS.hidden = true
        row4CS.hidden = true
        
        row1.translatesAutoresizingMaskIntoConstraints = false
        row2.translatesAutoresizingMaskIntoConstraints = false
        row3.translatesAutoresizingMaskIntoConstraints = false
        row4.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(row1)
        self.view.addSubview(row2)
        self.view.addSubview(row3)
        self.view.addSubview(row4)
        
        addConstraintsToInputView(self.view, rowViews: [row1, row2, row3, row4])
    }
    
    func createRowOfButtons(buttonTitles: [NSString]) -> UIView {
        var buttons = [UIButton]()
        let keyboardRowView = UIView(frame: CGRectMake(0, 0, 320.0, rowHeight))
        
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
        button.frame = CGRectMake(0, 0, 15.0, 15.0)
        button.setTitle(title, forState: .Normal)
        button.sizeToFit()
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        button.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        
        button.addTarget(self, action: #selector(keyPressed), forControlEvents: .TouchUpInside)
        
        return button
    }
    
    func keyPressed(sender: AnyObject?) {
        let numbers = ["1","2","3","4","5","6","7","8","9","0"]
        let button = sender as! UIButton
        let title = button.titleForState(.Normal)
        if(title == "\u{1F310}"){ //Change keyboard
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
        else if(title == "?"){
            currentTestKey = "?"
            label.text = ""
            hideDefaultView()
        }
        else if(title == "Back"){
            showDefaultView()
        }
        else if(numbers.contains(title!)){
            label.text = label.text! + title!
            
        }
        else if(title == "FN"){
            (textDocumentProxy as UIKeyInput).insertText(Lorem.firstName)
        }
        else if(title == "LN"){
            (textDocumentProxy as UIKeyInput).insertText(Lorem.lastName)
        }
        else if (title == "@"){
            (textDocumentProxy as UIKeyInput).insertText(Lorem.email)
        }
        else if (title == "ABC"){
            let string = "The quick brown fox jumps over the lazy dog"
            (textDocumentProxy as UIKeyInput).insertText(string)
        }
        else if (title == "#"){
            (textDocumentProxy as UIKeyInput).insertText(Lorem.tweet)
        }
        else if (title == "Date"){
            (textDocumentProxy as UIKeyInput).insertText(String(Lorem.date))
        }
        else if (title == "URL"){
            (textDocumentProxy as UIKeyInput).insertText(String(Lorem.URL))
        }
        else if (title == "XSS"){
            (textDocumentProxy as UIKeyInput).insertText("<script>alert('TesterKey!')</script>")
        }
        else if (title == "Lorem"){
            currentTestKey = "Lorem"
            label.text = ""
            hideDefaultView()
        }
        else if(title == "Copy"){
            if(defaultViewHidden == true){
                UIPasteboard.generalPasteboard().string = label.text
            }else{
                UIPasteboard.generalPasteboard().string = textDocumentProxy.documentContextBeforeInput
            }
            hideDefaultView()
            
        }
        else if(title == "\u{232B}"){ //Backspace
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
        else if(title == "\u{23CE}"){ //Enter key
            var textToInsert = ""
            if(currentTestKey == "CS" && Int(label.text!) > 0){
                let utils = Utils()
                textToInsert = utils.counterString(Int(label.text!)!,posMarker: "x")
            }else if (currentTestKey == "W" && Int(label.text!) > 0){
                textToInsert = String(count: Int(label.text!)!, repeatedValue: ("W" as Character))
            }else if(currentTestKey == "Lorem" && Int(label.text!) > 0){
                textToInsert = Lorem.sentences(Int(label.text!)!)
            }else if(currentTestKey == ""){
                textToInsert = "\n"
            }else if(currentTestKey == "?"){
                let intSize = UInt32(label.text!)
                textToInsert = String(Int(arc4random_uniform(intSize!)))
            }
            
            (textDocumentProxy as UIKeyInput).insertText(textToInsert)
            showDefaultView()
            currentTestKey = ""

        }
        else if(title == "\u{2423}"){ //Spacebar
             (textDocumentProxy as UIKeyInput).insertText(" ")
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
