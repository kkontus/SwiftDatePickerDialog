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
    private let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private let cancelButton = UIButton()
    private let okButton = UIButton()
    private let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private var selectedValue: String = DateHelper.getCurrentDate()
    //properties exposed to developer/user
    var titleDialog: String = ""
    var defaultDate: String = "" //DateHelper.getYesterday()
    var componentName: DialogDatePickerEnum?
    var delegateDialogDatePicker: DialogDatePickerDelegate?
    
    deinit {
        print("\(type(of: self)) was deallocated")
    }
    
    override func viewDidLoad() {
        print("\(type(of: self)) did load")
        super.viewDidLoad()
        
        showDatePickerDialogView()
    }
    
    func okButtonAction(_ sender: UIButton!) {
        print("Button tapped ok")
        self.delegateDialogDatePicker?.onDatePickerValueChange(self.componentName!, value: self.selectedValue)
        self.dismiss(animated: false, completion: nil)
    }
    
    func cancelButtonAction(_ sender: UIButton!) {
        print("Button tapped cancel")
        //self.delegateDialogDatePicker?.onDatePickerValueChange(self.componentName!, value: self.selectedValue)
        self.delegateDialogDatePicker?.onDatePickerValueChange(self.componentName!, value: "")
        self.dismiss(animated: false, completion: nil)
    }
    
    func onDateChanged(_ sender: UIDatePicker) {
        let dateSelected = DateHelper.getDateStringForGivenDateObject(sender.date, format: "yyyy-MM-dd")
        print("\(type(of: self)) onPickerValueChange")
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
    
    private func createDatePickerDialogView() {
        datePickerDialogView = UIView()
        datePickerDialogView.layer.borderWidth = 1
        datePickerDialogView.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        datePickerDialogView.layer.cornerRadius = 8.0
        datePickerDialogView.clipsToBounds = true
        datePickerDialogView.backgroundColor = UIColor.white
        
        datePickerDialogView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(datePickerDialogView)
        
        datePickerDialogView.widthAnchor.constraint(equalToConstant: datePickerDialogViewWidth).isActive = true
        datePickerDialogView.heightAnchor.constraint(equalToConstant: datePickerDialogViewHeight).isActive = true
        datePickerDialogView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePickerDialogView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func createTitleView() {
        titleView.backgroundColor = UIColor.white
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.datePickerDialogView.addSubview(titleView)
        
        titleView.widthAnchor.constraint(equalToConstant: datePickerDialogViewWidth).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        titleView.centerXAnchor.constraint(equalTo: self.datePickerDialogView.centerXAnchor).isActive = true
        titleView.topAnchor.constraint(equalTo: self.datePickerDialogView.topAnchor).isActive = true
    }
    
    private func createTitleLabel() {
        let title = titleDialog
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        titleLabel.text = title
        titleLabel.textColor = UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleView.addSubview(titleLabel)
        
        titleLabel.widthAnchor.constraint(equalToConstant: datePickerDialogViewWidth-10).isActive = true // 10 is for padding, 5 on each side since we have centerX
        titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    private func createDatePicker() {
        //datePicker.timeZone = NSTimeZone.localTimeZone()
        datePicker.datePickerMode = .date
        // add an event called when value is changed.
        datePicker.addTarget(self, action: #selector(onDateChanged), for: .valueChanged)
        
        if self.defaultDate != "" && DateHelper.isValidDateFormat(self.defaultDate, dayProvided: true) {
            self.selectedValue = self.defaultDate
            let dateToObject = DateHelper.getDateObjectForGivenDateString(self.defaultDate)
            datePicker.setDate(dateToObject, animated: false)
        }
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        self.datePickerDialogView.addSubview(datePicker)
        
        datePicker.widthAnchor.constraint(equalToConstant: 270.0).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 216.0).isActive = true
        datePicker.centerXAnchor.constraint(equalTo: self.datePickerDialogView.centerXAnchor).isActive = true
        datePicker.centerYAnchor.constraint(equalTo: self.datePickerDialogView.centerYAnchor).isActive = true
    }
    
    private func createCancelButton() {
        cancelButton.backgroundColor = UIColor.white
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        cancelButton.setTitle("Cancel", for: UIControlState())
        cancelButton.setTitleColor(UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1), for: UIControlState())
        cancelButton.widthAnchor.constraint(equalToConstant: datePickerDialogViewWidth / 2).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    private func createOkButton() {
        okButton.backgroundColor = UIColor.white
        okButton.setTitle("OK", for: UIControlState())
        okButton.addTarget(self, action: #selector(okButtonAction), for: .touchUpInside)
        okButton.setTitleColor(UIColor(red: 0.0, green: 122/255, blue: 1.0, alpha: 1), for: UIControlState())
        okButton.widthAnchor.constraint(equalToConstant: datePickerDialogViewWidth / 2).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
    }
    
    private func createStackView() {
        stackView.backgroundColor = UIColor.white
        stackView.axis = UILayoutConstraintAxis.horizontal
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = 0.0
        
        stackView.addArrangedSubview(cancelButton)
        stackView.addArrangedSubview(okButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.datePickerDialogView.addSubview(stackView)
        
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.datePickerDialogView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.datePickerDialogView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.datePickerDialogView.bottomAnchor).isActive = true
    }
    
}

