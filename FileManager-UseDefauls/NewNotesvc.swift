//
//  NewNotesvc.swift
//  FileManager-UseDefauls
//
//  Created by DCS on 07/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NewNotesvc: UIViewController {
    
    var updatefile = ""
    // make instance
    let service = DataService()
    private let FileName:UITextField = {
        let txt = UITextField()
        txt.placeholder = "Enter File Name"
        txt.textColor = .blue
        txt.borderStyle = .roundedRect
        txt.font = UIFont(name : "", size : 20.0)
        txt.textAlignment = .center
        
        return txt
    }()
    private let contentView:UITextView = {
        let txtView = UITextView()
        txtView.textColor = .black
        
        return txtView
    }()
    private let mybtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Save Me!!", for: .normal)
        btn.addTarget(self, action: #selector(saveNote), for: .touchUpInside)
        btn.backgroundColor = .green
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    @objc private func saveNote(){
        let name = FileName.text
        let content = contentView.text
        let filePath = service.getDocDir().appendingPathComponent("\(String(describing: name)).txt")
        //add content to file
        
        do{
            try content?.write(to: filePath, atomically: true, encoding: .utf8)
            let fetchContent = try String(contentsOf: filePath)
            print(fetchContent)
            
            // check content to file
            
            FileName.text = ""
            contentView.text = ""
            let  alert = UIAlertController(title: "Success!", message: "Your file is saved \(FileName).txt", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {[weak self]  _ in self?.navigationController?.popViewController(animated: true)}))
            DispatchQueue.main.async {
                self.present(alert,animated: true,completion: nil)
            }
        }catch{
            print(error)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(FileName)
        view.addSubview(contentView)
        view.addSubview(mybtn)
        
        if updatefile != ""{
            // here extract only file name separeted by dote exyension of file
            FileName.text = updatefile.components(separatedBy: ".").first
            let filePath = service.getDocDir().appendingPathComponent(updatefile)
            do{
                
                let content = try String(contentsOf: filePath)
               
                contentView.text = content
                
            }catch{
                print(error)
            }        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        FileName.frame = CGRect(x: 40, y: view.safeAreaInsets.top + 20, width: view.width - 80, height: 40)
        contentView.frame = CGRect(x: 40, y: FileName.bottom + 20, width: view.width - 80, height: 400)
        mybtn.frame = CGRect (x: 40, y: contentView.bottom + 20, width: view.width - 80, height: 40)
    }

}
