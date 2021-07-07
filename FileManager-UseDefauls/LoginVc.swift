//
//  LoginVc.swift
//  FileManager-UseDefauls
//
//  Created by DCS on 07/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class LoginVc: UIViewController {

    
    private let usertxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "ENTER USER NAME "
        txt.textColor = .blue
        //txt.autocorrectionType = .
        txt.autocapitalizationType = .none
        txt.borderStyle = .roundedRect
        txt.textAlignment = .center
        txt.borderStyle = .roundedRect
        
        return txt
    }()
    private let pswdtxt:UITextField = {
        let txt = UITextField()
        txt.placeholder = "ENTER PASSWORD "
        txt.textColor = .blue
        txt.isSecureTextEntry = true
        //txt.autocorrectionType = .
        txt.autocapitalizationType = .none
        txt.borderStyle = .roundedRect
        txt.textAlignment = .center
        txt.borderStyle = .roundedRect
        
        return txt
    }()
    
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("LOGIN", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.borderWidth = 5
        
        btn.addTarget(self, action: #selector(loginfunc), for: .touchUpInside)
        btn.backgroundColor = .green
        btn.layer.cornerRadius = 27
        
        return btn
    }()
    @objc private func loginfunc(){
        if usertxt.text == "vishakha" && pswdtxt.text == "vishakha"{
            UserDefaults.standard.setValue("abcdefg", forKey: "sessionToken")
            UserDefaults.standard.setValue(usertxt.text, forKey: "username")
            self.dismiss(animated: true)
            
        }
        else{
            let  alert = UIAlertController(title: "Incorrect!", message: "Username and password is incorrect !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "LOGIN"
        view.addSubview(pswdtxt)
        view.addSubview(usertxt)
        view.addSubview(mybtn)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usertxt.frame = CGRect(x: 20,y: 300, width: view.width - 40, height: 50)
        pswdtxt.frame = CGRect(x: 20,y: usertxt.bottom + 10, width: view.width - 40, height: 50)
        mybtn.frame = CGRect(x: 20,y: pswdtxt.bottom + 10, width: view.width - 40, height: 50)
        
    }

}
