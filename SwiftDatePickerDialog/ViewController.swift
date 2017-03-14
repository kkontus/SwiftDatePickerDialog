//
//  ViewController.swift
//  SwiftDatePickerDialog
//
//  Created by Kristijan Kontus on 26/08/2016.
//  Copyright © 2016 kkontus. All rights reserved.
//

import UIKit

enum DialogDatePickerEnum {
    case dateFrom
    case dateTo
}

protocol DialogDatePickerDelegate {
    func onDatePickerValueChange(_ component: DialogDatePickerEnum, value: String)
}

class ViewController: UIViewController, DialogDatePickerDelegate {
    var datePickerDialogViewController: DatePickerDialogViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onButtonClick(_ sender: UIButton) {
        datePickerDialogViewController = DatePickerDialogViewController()
        datePickerDialogViewController.titleDialog = "Date from"
        //datePickerDialogViewController.defaultDate = DateHelper.getCurrentDate() // no need to supply this value, default day is today
        datePickerDialogViewController.componentName = DialogDatePickerEnum.dateFrom
        datePickerDialogViewController.delegateDialogDatePicker = self
        datePickerDialogViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(datePickerDialogViewController, animated: false, completion: nil)
    }
    
    func onDatePickerValueChange(_ component: DialogDatePickerEnum, value: String) {
        print("\(type(of: self)) onDatePickerValueChange")
        print(component)
        print(value)
    }

}

