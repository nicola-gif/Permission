//
//  TipsManager.swift
//  PermissionConponent
//
//  Created by nicola on 2020/1/7.
//

import Foundation

struct TipsManager {
    
    private let tipsInfo: PermissionTipable
    
    init(_ tipsInfo: PermissionTipable) {self.tipsInfo = tipsInfo}
    
    func show() {
        let alertVC = UIAlertController(title: tipsInfo.title, message: tipsInfo.desc, preferredStyle: .alert)
        let tempTipsManager = tipsInfo
        alertVC.addAction(UIAlertAction(title: tipsInfo.okActionTitle, style: .default, handler: { _ in
            tempTipsManager.okAction()
        }))
        
        alertVC.addAction(UIAlertAction(title: tipsInfo.cancelActionTitle, style: .cancel, handler: { _ in
            tempTipsManager.cancelAction()
        }))
        
        tipsInfo.presentingVC?.present(alertVC, animated: true, completion: nil)
    }
}
