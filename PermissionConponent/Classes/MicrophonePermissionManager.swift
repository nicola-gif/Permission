//
//  MicrophonePermissionManager.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/7.
//

import Foundation
import AVFoundation

struct MicrophonePermissionManager: Permissionable {
    
    var currentPermissionDetail: PermissionDetail {
        let status = AVAudioSession.sharedInstance().recordPermission()
        switch status {
        case .denied:
            return .denied
        case .granted:
            return .permit
        case .undetermined:
            return .noDetermine
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
            let session = AVAudioSession()
            do {
                try session.setCategory("AVAudioSessionCategoryPlayAndRecord")
                session.requestRecordPermission {
                    self.handleStatus(by: $0 ? .permit : .denied, completed: completed)
                }
            }catch {
                completed(.other(error.localizedDescription))
            }
        case .servicesUnavailable: break
        }
    }
}

struct MicrophoneTipsManager: PermissionTipable {
    
    var desc: String {
        return "请在设置->隐私->麦克风->\(Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "你的APP名称")中设置允许"
    }
}
