//
//  ViewController.swift
//  XQSiriDemo
//
//  Created by WXQ on 2019/9/27.
//  Copyright © 2019 WXQ. All rights reserved.
//

import UIKit
import IntentsUI

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, INUIAddVoiceShortcutViewControllerDelegate,  INUIEditVoiceShortcutViewControllerDelegate {
    
    let result = "cell"
    var tableView: UITableView!
    var dataArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.initTableView()
        
        INPreferences.requestSiriAuthorization { (status) in
            switch (status) {
            case .notDetermined:
                print("用户尚未对该应用程序作出选择。")
                break;
            case .restricted:
                print("此应用程序无权使用Siri服务");
                break;
            case .denied:
                print("用户已明确拒绝此应用程序的授权");
                break;
            case .authorized:
                print("用户可以使用此应用程序的授权");
                break;
            default:
                break;
            }
        }
        
        XQTestObjOne().asd()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.frame = self.view.bounds
    }
    
    func initTableView() {
        
        self.dataArr = [
            "查看短语",
        ]
        
        self.tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        self.view.addSubview(self.tableView)
        
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: result)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 70
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: result, for: indexPath)
        cell.textLabel?.text = self.dataArr[indexPath.row]
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(XQAllVoiceShortcutsVC(), animated: true)
            
        default:
            break
        }
        
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



class XQTestObj: NSObject {
    
}

class XQTestObjOne: XQTestObj, XQProtocolOne, XQProtocolTwo, XQProtocolThree {
    var str: String = ""
}


protocol XQProtocolOne {
    var str: String {get set}
}

protocol XQProtocolTwo: NSObjectProtocol {
    func asd()
}

protocol XQProtocolThree: NSObjectProtocol {
    func testsss()
}

extension XQProtocolOne where Self:XQProtocolTwo, Self:XQProtocolThree {
    func asd() {
        print("asd")
    }
    
    func testsss() {
        print("test")
    }
}





