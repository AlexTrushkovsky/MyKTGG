//
//  ForgotPassViewController.swift
//  authKTGG
//
//  Created by Алексей Трушковский on 18.02.2020.
//  Copyright © 2020 Алексей Трушковский. All rights reserved.
//

import UIKit
import Firebase
class ForgotPassViewController: UIViewController {
    @IBOutlet weak var restoreLabel: UIImageView!
    @IBOutlet weak var emailFieldView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func showAlertOk(alert: UIAlertAction!) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func restoreButton(_ sender: UIButton) {
        var email = ""
        if !emailTextField.text!.isEmpty{
            if (emailTextField.text!.contains("@")){
                email=emailTextField.text!
            }else{
                showAlert(title: "Помилка", message: "Ви ввели не дійсний email")
            }
            if (!email.isEmpty){
                Auth.auth().sendPasswordReset(withEmail: email){ (error) in
                    if error == nil{
                        let alert = UIAlertController(title: "Готово", message: "Перевірте поштову скриньку", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: self.showAlertOk(alert: )))
                        self.present(alert, animated: true, completion: nil)
                    }else{
                        self.showAlert(title: "Помилка", message: "Користувача з даним email не існує")
                    }
                }
            }
        }else{
            showAlert(title: "Помилка", message: "Всі поля обов'язкові до заповнення")
        }
    }
}
