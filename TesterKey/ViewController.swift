//
//  ViewController.swift
//  TesterKey
//
//  Created by Risko Ruus on 19/07/16.
//  Copyright © 2016 Risko Ruus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = NSUserDefaults(suiteName: "group.eu.testandrest.1000Fingers")
        defaults?.setObject("It worked!", forKey: "alarmTime")
        defaults?.synchronize()
        
        let settingsButton = UIButton(frame: CGRect(x: 100, y: 100, width: 200, height: 50))
        settingsButton.backgroundColor = .greenColor()
        settingsButton.setTitle("Keyboard Settings", forState: .Normal)
        settingsButton.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        let textField = UITextField(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.blackColor().CGColor
        
        self.view.addSubview(settingsButton)
        self.view.addSubview(textField)
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

