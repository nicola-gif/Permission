//
//  PhotoPermissionManager.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/7.
//

import Foundation
import Photos

struct PhotoPermissionManager: Permissionable {
    
    var currentPermissionDetail: PermissionDetail {
        let status = PHPhotoLibrary.authorizationStatus()
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
        let status = PHPhotoLibrary.authorizationStatus()
        self.handleByStatus(status, completed: completed)
    }
    
    private func handleByStatus(_ status: PHAuthorizationStatus, completed: @escaping (PermissionDetail) -> Void) {
        switch status {
        case .authorized:
            completed(.permit)
        case .denied, .restricted:
            completed(.denied)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization {
                self.handleByStatus($0, completed: completed)
            }
        }
    }
}

struct PhotoTipsManager: PermissionTipable {
    
    var desc: String {
        return "请在设置->隐私->照片->\(Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "你的APP名称")中设置允许读取和写入"
    }
}
