//
//  CameraPermissionManager.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/7.
//

import Foundation
import AVFoundation

struct CameraPermissionManager: Permissionable {
    
    var currentPermissionDetail: PermissionDetail {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
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
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        self.handleByStatus(status, completed: completed)
    }
    
    private func handleByStatus(_ status: AVAuthorizationStatus, completed: @escaping (PermissionDetail) -> Void) {
        switch status {
        case .authorized:
            completed(.permit)
        case .denied, .restricted:
            completed(.denied)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) {
                self.handleByStatus($0 ? .authorized : .denied, completed: completed)
            }
        }
    }
}

struct CameraTipsManager: PermissionTipable {
    
    var desc: String {
        return "请在设置->隐私->相机->\(Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "你的APP名称")中设置允许"
    }
}
