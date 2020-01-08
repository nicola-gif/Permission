//
//  Permissionable.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/7.
//

import Foundation

public protocol Permissionable {
    
    /// 当前权限细节
    var currentPermissionDetail: PermissionDetail {get}
    
    /// 请求权限
    /// - Parameters:
    ///   - permissionType: 请求的权限类型
    ///   - completed: 请求完成后的回调
    func requestPermission(completed: @escaping (PermissionDetail)->Void)
    
}
