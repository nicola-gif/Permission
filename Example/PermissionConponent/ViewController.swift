//
//  ViewController.swift
//  PermissionConponent
//
//  Created by nicolalkjhgfdsa@gmail.com on 01/07/2020.
//  Copyright (c) 2020 nicolalkjhgfdsa@gmail.com. All rights reserved.
//

import UIKit
import PermissionConponent

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photoPermissionAction(_ sender: UIButton) {
        PermissionManager.share.requestPermission(by: .photo) {self.handlePermission(status: $0)}
    }
    
    @IBAction func cameraPermissionAction(_ sender: UIButton) {
        PermissionManager.share.requestPermission(by: .camera) {self.handlePermission(status: $0)}
    }
    

    @IBAction func contactPermissionAction(_ sender: UIButton) {
        PermissionManager.share.requestPermission(by: .contact) {self.handlePermission(status: $0)}
    }
    
    @IBAction func calendarPermissionAction(_ sender: UIButton) {
        PermissionManager.share.requestPermission(by: .calendar) {self.handlePermission(status: $0)}
    }
    
    @IBAction func recordPermissionAction(_ sender: UIButton) {
        PermissionManager.share.requestPermission(by: .microphone) {self.handlePermission(status: $0)}
    }
    
    @IBAction func locationPermissionAction(_ sender: UIButton) {
        PermissionManager.share.requestPermission(by: .location) {self.handlePermission(status: $0)}
    }
    
    private func handlePermission(status: PermissionDetail) {
        switch status {
        case .denied:
            debugPrint("访问拒绝")
        case .noDetermine:
            debugPrint("没有做决定")
        case .permit:
            debugPrint("允许访问")
        case .other(let s):
            debugPrint("其他错误: \(s)")
        case .servicesUnavailable:
            debugPrint("服务不可用")
        }
    }
    
}

