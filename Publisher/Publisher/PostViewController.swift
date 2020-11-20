//
//  PostViewController.swift
//  Publisher
//
//  Created by prince on 2020/11/20.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView! {
        
        didSet {
            
            backgroundView.layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var categoryTextField: UITextField! {
        
        didSet {
            
            let picker = UIPickerView()
            picker.delegate = self
            picker.dataSource = self
            categoryTextField.inputView = picker
            picker.tag = 0
        }
    }
    
    @IBOutlet weak var contentTextView: UITextView! {
        
        didSet {
            
            contentTextView.layer.borderWidth = 0.5
            contentTextView.layer.borderColor = UIColor.lightGray.cgColor
            contentTextView.layer.cornerRadius = 5
            contentTextView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var postButton: UIButton! {
        
        didSet {
            
            postButton.layer.cornerRadius = 5
        }
    }
    
    var categoryArray = ["", "Beauty", "Gossiping", "IU"]
    
    let firebase = FirebaseManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func postButtonDidTap(_ sender: UIButton) {
        
        firebase.addData(title: titleTextField.text ?? "",
                         category: categoryTextField.text ?? "",
                         content: contentTextView.text ?? "")
        
        dismiss(animated: true, completion: nil)
    }
    
    
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension PostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { categoryArray.count }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { categoryArray[row] }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) { categoryTextField.text = categoryArray[row] }
}
