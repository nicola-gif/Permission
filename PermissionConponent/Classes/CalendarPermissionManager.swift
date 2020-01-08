//
//  Calendar.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/7.
//

import Foundation
import EventKit

struct CalendarPermissionManager: Permissionable {
    
    var currentPermissionDetail: PermissionDetail {
        let status = EKEventStore.authorizationStatus(for: .event)
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
    
    func requestPermission(completed: @escaping (PermissionDetail) -> Void) {
        handleStatus(by: currentPermissionDetail, completed: completed)
    }
    
    private func handleStatus(by status: PermissionDetail, completed: @escaping (PermissionDetail) -> Void) {
        switch status {
        case .permit:
            completed(.permit)
        case .denied, .other:
            completed(.denied)
        case .noDetermine:
            EKEventStore().requestAccess(to: .event) { (granted, error) in
                self.handleStatus(by: granted ? .permit : .denied, completed: completed)
            }
        case .servicesUnavailable: break
        }
    }
}

struct CalendarTipsManager: PermissionTipable {
    
    var desc: String {
        return "请在设置->隐私->日历->\(Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "你的APP名称")中设置允许"
    }
}
