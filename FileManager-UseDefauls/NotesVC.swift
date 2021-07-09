//
//  NotesVC.swift
//  FileManager-UseDefauls
//
//  Created by DCS on 07/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class NotesVC: UIViewController {
    
    private var notesArray = [String]()
    private let notestbl = UITableView()
    var del = ""
    // make instance
    let service = DataService()
    
   
    @objc private func logoutFunc(){
        
        UserDefaults.standard.setValue(nil, forKey: "sessionToken")
        checkAuth()
    }
    /*
     @objc private func saveNote(){
     let name = FileName.text!
     let content = contentView.text!
     let filePath = service.getDocDir().appendingPathComponent("\(name).txt")
     //add content to file
     
     do{
     try content.write(to: filePath, atomically: true, encoding: .utf8)
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
 */
    // extract notes from directory
    private func fetchNotes(){
        
        
        
        let path = service.getDocDir()
        do{
            let item = try FileManager.default.contentsOfDirectory(at : path, includingPropertiesForKeys: nil)
            notesArray.removeAll()
            for i in item{
                notesArray.append(i.lastPathComponent)
            }
        }catch{
            print(error)
        }
        
    
        notestbl.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchNotes()
        checkAuth()
        
    }
    private func checkAuth(){
        
        if let token = UserDefaults.standard.string(forKey: "sessionToken"),
        let name = UserDefaults.standard.string(forKey: "username")
        {
            print("token :: \(name) | \(token)")
            
        }
        else{
            let vc = LoginVc()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.setNavigationBarHidden(true, animated: false)
            present(nav,animated: false)
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        notestbl.frame = view.bounds
    }
    // create document directory
    
    
    @objc private func openNotes(){
        let vc = NewNotesvc()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "NOTES"
        print(service.getDocDir())
        view.addSubview(notestbl)
        let additem1 = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(logoutFunc))
        navigationItem.setRightBarButton(additem1, animated: true)
        let additem2 = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openNotes))
        navigationItem.setLeftBarButton(additem2, animated: true)
        
        
        setuptbl()
        fetchNotes()
        // Do any additional setup after loading the view.
    }}
extension NotesVC: UITableViewDelegate,UITableViewDataSource {
    
    private func setuptbl(){
        
        notestbl.register(UITableViewCell.self, forCellReuseIdentifier: "noteCell")
        notestbl.delegate = self
        notestbl.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for : indexPath)
        cell.textLabel?.text = notesArray[indexPath.row]
        return cell
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //let del = notesArray[indexPath.row]
        if editingStyle == .delete
        {
            notestbl.beginUpdates()
            
           
            //tableView.deleteRows(at: [indexPath], with: .automatic)
           // self.notesArray.remove(at: indexPath.row)
            let filename = notesArray[indexPath.row]
            

            let filepath = service.getDocDir().appendingPathComponent(filename)                //.deletingLastPathComponent("\(filename).txt")

             let path = URL(string: filename, relativeTo: filepath)
            
            do
            {
                try FileManager.default.removeItem(at: path! )
                let alert = UIAlertController(title: "Success !", message: "File Deleted Successfully ......", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel , handler: {[weak self]  _ in self?.navigationController?.popViewController(animated: true)}))
                
                DispatchQueue.main.async
                {
                    self.present(alert,animated: true,completion: nil)
                }
            }
            catch
            {
                print(error)
            }
            /*
            else{
                print("not get path")
            }
            */
            
            notesArray.remove(at: indexPath.row)
            notestbl.deleteRows(at: [indexPath], with: .fade)
            notestbl.reloadData()
            notestbl.endUpdates()
            
        }
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewNotesvc()
        vc.updatefile = notesArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
