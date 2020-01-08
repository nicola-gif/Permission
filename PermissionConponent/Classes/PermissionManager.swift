//
//  PermissionManager.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/8.
//

import Foundation

public class PermissionManager {
    
    lazy private var calendarManager: Permissionable = {return CalendarPermissionManager()}()
    private var calendarTipInfo: PermissionTipable?
    
    lazy private var cameraManager: Permissionable = {return CameraPermissionManager()}()
    private var cameraTipInfo: PermissionTipable?
    
    lazy private var contactManager: Permissionable = {return ContactsPermissionManager()}()
    private var contactTipInfo: PermissionTipable?
    
    lazy private var microphoneManager: Permissionable = {return MicrophonePermissionManager()}()
    private var microphoneTipInfo: PermissionTipable?
    
    lazy private var photoManager: Permissionable = {return PhotoPermissionManager()}()
    private var photoTipInfo: PermissionTipable?
    
    lazy private var reminderManager: Permissionable = {return ReminderPermissionManager()}()
    private var reminderTipInfo: PermissionTipable?
    
    lazy private var locationManager: Permissionable = {return LocationPermissionManager()}()
    private var locationTipInfo: PermissionTipable?
    
    public static let share: PermissionManager = PermissionManager()
    private init() {}
    
    public func requestPermission(by type: PermissionType, tipsInfo: PermissionTipable? = nil, ifDeniedHandleDefault: Bool = true, completed: @escaping (PermissionDetail)->Void) {
        let manager: Permissionable?
        switch type {
        case .calendar:
            manager = calendarManager
            calendarTipInfo = tipsInfo ?? CalendarTipsManager()
        case .camera:
            manager = cameraManager
            cameraTipInfo = tipsInfo ?? CameraTipsManager()
        case .contact:
            manager = contactManager
            contactTipInfo = tipsInfo ?? ContactTipsManager()
        case .microphone:
            manager = microphoneManager
            microphoneTipInfo = tipsInfo ?? MicrophoneTipsManager()
        case .photo:
            manager = photoManager
            photoTipInfo = tipsInfo ?? PhotoTipsManager()
        case .reminder:
            manager = reminderManager
            reminderTipInfo = tipsInfo ?? ReminderTipsManager()
        case .location:
            manager = locationManager
            locationTipInfo = tipsInfo ?? LocationTipsManager()
        default:
            manager = nil
        }
        
        ifDeniedHandleDefault == false ? manager?.requestPermission(completed: completed) : manager?.requestPermission { [weak self] in
            switch $0 {
            case .permit:
                completed($0)
            default:
                self?.handleDenied(type, $0)
            }
        }
    }
    
    private func handleDenied(_ type: PermissionType, _ permission: PermissionDetail) {
        let alertManager: PermissionTipable?
        switch type {
        case .calendar:
            alertManager = self.calendarTipInfo
        case .camera:
            alertManager = self.cameraTipInfo
        case .contact:
            alertManager = self.contactTipInfo
        case .microphone:
            alertManager = self.microphoneTipInfo
        case .photo:
            alertManager = self.photoTipInfo
        case .reminder:
            alertManager = self.reminderTipInfo
        case .location:
            alertManager = self.locationTipInfo
        default:
            alertManager = nil
        }
        guard let m = alertManager else {return}
        let tipManager = TipsManager(m)
        tipManager.show()
    }
    
}
