//
//  LocationPermissionManager.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/8.
//

import Foundation
import CoreLocation

struct LocationPermissionManager: Permissionable {
    
    var currentPermissionDetail: PermissionDetail {
        if CLLocationManager.locationServicesEnabled() == false {
            return .servicesUnavailable
        }
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
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
        self.handleStatus(by: currentPermissionDetail, completed: completed)
    }
    
    private func handleStatus(by status: PermissionDetail, completed: @escaping (PermissionDetail) -> Void) {
        switch status {
        case .permit:
            completed(.permit)
        case .denied, .other:
            completed(.denied)
        case .servicesUnavailable:
            completed(.servicesUnavailable)
        case .noDetermine:
            debugPrint("等待实现!!!")
        }
    }
    
    
}

struct LocationTipsManager: PermissionTipable {
    
    var desc: String {
        return """
            1.请在设置->隐私->打开定位服务
            2.请在设置->隐私->定位服务->\(Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "你的APP名称")中勾选使用APP期间或者始终
        """
    }
}
