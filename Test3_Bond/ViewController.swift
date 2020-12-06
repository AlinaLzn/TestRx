//
//  ViewController.swift
//  Test3_Bond
//
//  Created by Alina on 2020-11-26.
//

import UIKit
import Bond
import ReactiveKit

class ViewController: UIViewController {
    
    var viewModel = ViewModel()
//    let disposeBag = DisposeBag()

    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        secondNameTextField.delegate = self
        ageTextField.delegate = self
        
        viewModel.searchString()
        sendButton.layer.cornerRadius = 10
        bindViewModel()
        observeData()
    }
    
    func observeData() {
        _ = sendButton.reactive.controlEvents(.touchUpInside).observeNext { e in
            print("Click click")
        }
    }
    
//    @IBAction func sendAction(_ sender: UIButton) {
//        print("Click")
//    }
    
    func bindViewModel() {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .spellOut
        
//        viewModel.name.bidirectionalBind(to: nameTextField.reactive.text)
//        viewModel.secondName.bidirectionalBind(to:secondNameTextField.reactive.text)
//        viewModel.age.bidirectionalBind(to:ageTextField.reactive.text)

//        ageTextField.reactive.text
//            .map { formatter.string(from: $0) ?? ""}
//            .bind(to: viewModel.age)
//            .addDisposableTo(disposeBag)
        
        nameTextField.reactive.text
            .map { !$0!.isEmpty && $0!.count > 3 }
            .bind(to: viewModel.validName)
        
        secondNameTextField.reactive.text
            .map { !$0!.isEmpty && $0!.count > 3 }
            .bind(to: viewModel.validSecondName)
        
        ageTextField.reactive.text
            .map { !$0!.isEmpty && $0!.count < 4 }
            .bind(to: viewModel.validAge)
        
        viewModel.valided
            .bind(to: sendButton.reactive.isEnabled)
        viewModel.valided
            .map { $0 ? .green : .darkGray }
            .bind(to: sendButton.reactive.backgroundColor)
    }
    
    
    //    func changeButton() {
    ////        sendButton.backgroundColor = sendButton.isEnabled ? .green : .darkGray
    //        viewModel.valided
    //            .map { $0 ? .green : .darkGray }
    //            .bind(to: sendButton.reactive.backgroundColor)
    //    }
    
    //    func dataValidation() {
    ////        sendButton.isEnabled = viewModel.valided
    //        changeButton()
    //    }
    
    //    func observeData() {
    //
    //        _ = nameTextField.reactive.text
    //            .map { !$0!.isEmpty && $0!.count > 3 }
    //            .observeNext {
    //                [unowned self] text in
    ////                self.dataValidation()
    //                self.changeButton()
    //            }
    //
    //        _ = secondNameTextField.reactive.text
    //            .map { !$0!.isEmpty && $0!.count > 3 }
    //            .observeNext {
    //                [unowned self] text in
    ////                self.dataValidation()
    //                self.changeButton()
    //            }
    //
    //        _ = ageTextField.reactive.text
    //            .map { !$0!.isEmpty && $0!.count > 3 }
    //            .observeNext {
    //                [unowned self] text in
    ////                self.dataValidation()
    //                self.changeButton()
    //            }
    //    }
    //        _ = nameTextField.reactive.text.observeNext { text in
    //            self.dataValidation()
    //        }
    //
    //        _ = secondNameTextField.reactive.text.observeNext { text in
    //            self.dataValidation()
    //        }
    //    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        if textField == ageTextField {
            return string == string.filter("0123456789".contains)
        } else {
            return string == string.filter("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".contains)
        }
    }
}
