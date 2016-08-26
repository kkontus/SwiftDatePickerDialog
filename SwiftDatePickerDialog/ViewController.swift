//
//  ViewController.swift
//  SwiftDatePickerDialog
//
//  Created by Kristijan Kontus on 26/08/2016.
//  Copyright © 2016 kkontus. All rights reserved.
//

import UIKit

enum DialogDatePickerEnum {
    case DateFrom
    case DateTo
}

protocol DialogDatePickerDelegate {
    func onDatePickerValueChange(component: DialogDatePickerEnum, value: String)
}

class ViewController: UIViewController, DialogDatePickerDelegate {
    var datePickerDialogViewController: DatePickerDialogViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onButtonClick(sender: UIButton) {
        datePickerDialogViewController = DatePickerDialogViewController()
        datePickerDialogViewController.titleDialog = "Date from"
        //datePickerDialogViewController.defaultDate = DateHelper.getCurrentDate() // no need to supply this value, default day is today
        datePickerDialogViewController.componentName = DialogDatePickerEnum.DateFrom
        datePickerDialogViewController.delegateDialogDatePicker = self
        datePickerDialogViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        self.presentViewController(datePickerDialogViewController, animated: false, completion: nil)
    }
    
    func onDatePickerValueChange(component: DialogDatePickerEnum, value: String) {
        print("\(self.dynamicType) onDatePickerValueChange")
        print(component)
        print(value)
    }

}

