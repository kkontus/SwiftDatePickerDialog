//
//  DatePickerDialogViewController.swift
//  SwiftDatePickerDialog
//
//  Created by Kristijan Kontus on 26/08/2016.
//  Copyright © 2016 kkontus. All rights reserved.
//

import UIKit

class DatePickerDialogViewController: UIViewController {
    private let datePickerDialogViewWidth: CGFloat = 300.0
    private let datePickerDialogViewHeight: CGFloat = 250.0
    private var datePickerDialogView: UIView!
    private let titleView = UIView()
    private let titleLabel = UILabel(frame: CGRectMake(0, 0, 0, 0))
    private let datePicker = UIDatePicker(frame: CGRectMake(0, 0, 0, 0))
    private let cancelButton = UIButton()
    private let okButton = UIButton()
    private let stackView = UIStackView(frame: CGRectMake(0, 0, 0, 0))
    private var selectedValue: String = DateHelper.getCurrentDate()
    //properties exposed to developer/user
    var titleDialog: String = ""
    var defaultDate: String = "" //DateHelper.getYesterday()
    var componentName: DialogDatePickerEnum?
    var delegateDialogDatePicker: DialogDatePickerDelegate?
    
    deinit {
        print("\(self.dynamicType) was deallocated")
    }
    
    override func viewDidLoad() {
        print("\(self.dynamicType) did load")
        super.viewDidLoad()
        
        showDatePickerDialogView()
    }
    
    func okButtonAction(sender: UIButton!) {
        print("Button tapped ok")
        self.delegateDialogDatePicker?.onDatePickerValueChange(self.componentName!, value: self.selectedValue)
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func cancelButtonAction(sender: UIButton!) {
        print("Button tapped cancel")
        //self.delegateDialogDatePicker?.onDatePickerValueChange(self.componentName!, value: self.selectedValue)
        self.delegateDialogDatePicker?.onDatePickerValueChange(self.componentName!, value: "")
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func onDateChanged(sender: UIDatePicker) {
        let dateSelected = DateHelper.getDateStringForGivenDateObject(sender.date, format: "yyyy-MM-dd")
        print("\(self.dynamicType) onPickerValueChange")
        print(dateSelected)
        
        selectedValue = dateSelected
    }
    
    func showDatePickerDialogView() {
        createDatePickerDialogView()
        createTitleView()
        createTitleLabel()
        createDatePicker()
        createCancelButton()
        createOkButton()
        createStackView()
        self.view.layoutIfNeeded()
    }
    
    func createDatePickerDialogView() {
        datePickerDialogView = UIView()
        datePickerDialogView.layer.borderWidth = 1
        datePickerDialogView.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).CGColor
        datePickerDialogView.layer.cornerRadius = 8.0
        datePickerDialogView.clipsToBounds = true
        datePickerDialogView.backgroundColor = UIColor.whiteColor()
        
        datePickerDialogView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePickerDialogView)
        
        datePickerDialogView.widthAnchor.constraintEqualToConstant(datePickerDialogViewWidth).active = true
        datePickerDialogView.heightAnchor.constraintEqualToConstant(datePickerDialogViewHeight).active = true
        datePickerDialogView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        datePickerDialogView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
    }
    
    func createTitleView() {
        titleView.backgroundColor = UIColor.whiteColor()
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.datePickerDialogView.addSubview(titleView)
        
        titleView.widthAnchor.constraintEqualToConstant(datePickerDialogViewWidth).active = true
        titleView.heightAnchor.constraintEqualToConstant(30.0).active = true
        titleView.centerXAnchor.constraintEqualToAnchor(self.datePickerDialogView.centerXAnchor).active = true
        titleView.topAnchor.constraintEqualToAnchor(self.datePickerDialogView.topAnchor).active = true
    }
    
    func createTitleLabel() {
        let title = titleDialog
        titleLabel.font = UIFont.boldSystemFontOfSize(14.0)
        titleLabel.text = title
        titleLabel.textColor = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleView.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraintEqualToAnchor(titleView.centerXAnchor).active = true
        titleLabel.centerYAnchor.constraintEqualToAnchor(titleView.centerYAnchor).active = true
    }
    
    func createDatePicker() {
        //datePicker.timeZone = NSTimeZone.localTimeZone()
        datePicker.datePickerMode = .Date
        // add an event called when value is changed.
        datePicker.addTarget(self, action: #selector(onDateChanged), forControlEvents: .ValueChanged)
        
        if self.defaultDate != "" && DateHelper.isValidDateFormat(self.defaultDate, dayProvided: true) {
            self.selectedValue = self.defaultDate
            let dateToObject = DateHelper.getDateObjectForGivenDateString(self.defaultDate)
            datePicker.setDate(dateToObject, animated: false)
        }
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.datePickerDialogView.addSubview(datePicker)
        
        datePicker.widthAnchor.constraintEqualToConstant(270.0).active = true
        datePicker.heightAnchor.constraintEqualToConstant(216.0).active = true
        datePicker.centerXAnchor.constraintEqualToAnchor(self.datePickerDialogView.centerXAnchor).active = true
        datePicker.centerYAnchor.constraintEqualToAnchor(self.datePickerDialogView.centerYAnchor).active = true
    }
    
    func createCancelButton() {
        cancelButton.backgroundColor = UIColor.whiteColor()
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), forControlEvents: .TouchUpInside)
        cancelButton.setTitle("Cancel", forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1), forState: UIControlState.Normal)
        cancelButton.widthAnchor.constraintEqualToConstant(datePickerDialogViewWidth / 2).active = true
        cancelButton.heightAnchor.constraintEqualToConstant(30.0).active = true
    }
    
    func createOkButton() {
        okButton.backgroundColor = UIColor.whiteColor()
        okButton.setTitle("OK", forState: UIControlState.Normal)
        okButton.addTarget(self, action: #selector(okButtonAction), forControlEvents: .TouchUpInside)
        okButton.setTitleColor(UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1), forState: UIControlState.Normal)
        okButton.widthAnchor.constraintEqualToConstant(datePickerDialogViewWidth / 2).active = true
        okButton.heightAnchor.constraintEqualToConstant(30.0).active = true
    }
    
    func createStackView() {
        stackView.backgroundColor = UIColor.whiteColor()
        stackView.axis = UILayoutConstraintAxis.Horizontal
        stackView.distribution = UIStackViewDistribution.EqualSpacing
        stackView.alignment = UIStackViewAlignment.Center
        stackView.spacing = 0.0
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(okButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.datePickerDialogView.addSubview(stackView)
        
        stackView.heightAnchor.constraintEqualToConstant(30).active = true
        stackView.leadingAnchor.constraintEqualToAnchor(self.datePickerDialogView.leadingAnchor).active = true
        stackView.trailingAnchor.constraintEqualToAnchor(self.datePickerDialogView.trailingAnchor).active = true
        stackView.bottomAnchor.constraintEqualToAnchor(self.datePickerDialogView.bottomAnchor).active = true
    }
    
}

