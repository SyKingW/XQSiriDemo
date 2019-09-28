//
//  XQAllVoiceShortcutsVC.swift
//  XQSiriDemo
//
//  Created by WXQ on 2019/9/28.
//  Copyright © 2019 WXQ. All rights reserved.
//

import UIKit
import IntentsUI

class XQAllVoiceShortcutsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, INUIAddVoiceShortcutViewControllerDelegate,  INUIEditVoiceShortcutViewControllerDelegate {
    
    
    let result = "cell"
    var tableView: UITableView!
    var dataArr = [INVoiceShortcut]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "添加", style: .plain, target: self, action: #selector(respondsToAdd))
        
        self.initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.frame = self.view.bounds
        self.getData()
    }
    
    func getData() {
        self.dataArr.removeAll()
        self.tableView.reloadData()
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { (vsArr, error) in
            
            if let error = error {
                print("error: \(error)")
                return
            }
            
            guard let vsArr = vsArr else {
                print("数据为空")
                DispatchQueue.main.async {
                    self.dataArr.removeAll()
                    self.tableView.reloadData()
                }
                return
            }
            
            
            print(vsArr)
            self.dataArr.append(contentsOf: vsArr)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    
    
    func initTableView() {
        self.tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        self.view.addSubview(self.tableView)
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: result)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 70
        
    }
    
    @objc func respondsToAdd() {
        //        let intent = XQTestIntent.init()
//        let intent = XQTestOneIntent.init()
        let intent = XQTestDoIntent.init()
//        let intent = XQTestRunIntent.init()
//        let intent = XQTestGoIntent.init()
        intent.suggestedInvocationPhrase = "人类能理解的描述?"
        
        
//        let tImg = UIImage.init(named: "test222")
//        let data = tImg?.jpegData(compressionQuality: 0.5)
//        if let data = data {
//            let img = INImage.init(imageData: data)
//            intent.__setImage(img, forParameterNamed: "image")
//
//        }else {
//            print("没有data")
//            let img = INImage.init(url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "test111", ofType: "png") ?? "" ))
//            intent.__setImage(img, forParameterNamed: "")
//        }
        
        let img = INImage.init(url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "test222", ofType: "png") ?? "" ))
        intent.__setImage(img, forParameterNamed: "")
        
        
        if let shortcut = INShortcut.init(intent: intent) {
            let vc = INUIAddVoiceShortcutViewController.init(shortcut: shortcut)
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }else {
            print("创建失败")
        }
        
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: result, for: indexPath)
        cell.textLabel?.text = self.dataArr[indexPath.row].invocationPhrase
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = INUIEditVoiceShortcutViewController.init(voiceShortcut: self.dataArr[indexPath.row])
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - INUIAddVoiceShortcutViewControllerDelegate
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        print("完成")
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
        print("取消")
    }
    
    // MARK: - INUIEditVoiceShortcutViewControllerDelegate
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
        print(#function)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
        print(#function)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
        print(#function)
    }

}
