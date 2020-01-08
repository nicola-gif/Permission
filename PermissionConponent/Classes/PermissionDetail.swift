//
//  PermissionDetail.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/7.
//

public enum PermissionDetail {
    
    /// 拒绝
    case denied
    
    /// 没有决定
    case noDetermine
    
    /// 允许
    case permit
    
    /// 其他
    case other(String)
    
    /// 服务不可用
    case servicesUnavailable
}
