//
//  ContactsPermissionManager.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/7.
//

import Foundation
import AddressBook
import Contacts

struct ContactsPermissionManager: Permissionable {
    
    var currentPermissionDetail: PermissionDetail {
        if #available(iOS 9, *) {
            let status = CNContactStore.authorizationStatus(for: .contacts)
            switch status {
            case .authorized:
                return .permit
            case .denied:
                return .denied
            case .notDetermined:
                return .noDetermine
            case .restricted:
                return .other("无权限访问")
            }
        }else {
           let status = ABAddressBookGetAuthorizationStatus()
            switch status {
            case .authorized:
                return .permit
            case .denied:
                return .denied
            case .notDetermined:
                return .noDetermine
            case .restricted:
                return .other("无权限访问")
            }
        }
    }
    
    func requestPermission(completed: @escaping (PermissionDetail) -> Void) {
        self.handleByStatus(currentPermissionDetail, completed: completed)
    }
    
    private func handleByStatus(_ status: PermissionDetail, completed: @escaping (PermissionDetail) -> Void) {
        switch status {
        case .noDetermine:
            if #available(iOS 9, *) {
                CNContactStore().requestAccess(for: .contacts) { (granted, error) in
                    self.handleByStatus(granted ? .permit : .denied, completed: completed)
                }
            }else {
                ABAddressBookRequestAccessWithCompletion(ABAddressBookCreate() as ABAddressBook?) { (granted, error) in
                    self.handleByStatus(granted ? .permit : .denied, completed: completed)
                }
            }
        default:
            completed(status)
        }
    }
    
}

struct ContactTipsManager: PermissionTipable {
    
    var desc: String {
        return "请在设置->隐私->通讯录->\(Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "你的APP名称")中设置允许"
    }
}
