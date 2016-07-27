//
//  ViewController.swift
//  TesterKey
//
//  Created by Risko Ruus on 19/07/16.
//  Copyright © 2016 Risko Ruus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var f1KeyEditField = UITextField()
    var defaults = NSUserDefaults(suiteName: "group.eu.testandrest.TesterKey")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting Values
        if(defaults!.objectForKey("F1") == nil){
            defaults!.setObject("F1 default value", forKey: "F1")
        }
        
        defaults?.synchronize()
        
        let settingsButton = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        settingsButton.backgroundColor = .greenColor()
        settingsButton.setTitle("Keyboard Settings", forState: .Normal)
        settingsButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        let textField = UITextField(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blackColor().CGColor
        
        f1KeyEditField = UITextField(frame: CGRect(x: 100, y: 300, width: 200, height: 50))
        f1KeyEditField.placeholder = (defaults!.objectForKey("F1") as! String)
        f1KeyEditField.layer.borderWidth = 1
        f1KeyEditField.layer.borderColor = UIColor.blackColor().CGColor
        
        let f1SaveButton = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 50))
        f1SaveButton.backgroundColor = .greenColor()
        f1SaveButton.setTitle("Save to F1", forState: .Normal)
        f1SaveButton.addTarget(self, action: #selector(saveF1), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(settingsButton)
        self.view.addSubview(textField)
        self.view.addSubview(f1KeyEditField)
        self.view.addSubview(f1SaveButton)
    }
    
    func saveF1(sender: UIButton){
        defaults!.setObject("F1 default value", forKey: "F1")
        defaults!.setObject(f1KeyEditField.text, forKey: "F1")
        defaults!.synchronize()
        print("Saved " + f1KeyEditField.text! + " under F1")
    }
    
    func buttonAction(sender: UIButton!) {
        UIApplication.sharedApplication().openURL(NSURL(string:"prefs:root=General&path=Keyboard")!)
        print("Keyboard settings opened")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

