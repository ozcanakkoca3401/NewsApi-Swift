//
//  UIView+Ext.swift
//  PlaygroundPodProject
//
//  Created by Özcan AKKOCA on 13.12.2017.
//  Copyright © 2017 Özcan AKKOCA. All rights reserved.
//


import Foundation
import MBProgressHUD

// MARK: - Loading indicator extension
extension UIView{
    
    private struct hudStruct {
        static var hud = MBProgressHUD()
    }
    
    var hud:MBProgressHUD {
        get{
            return hudStruct.hud
        }
        
        set {
            hudStruct.hud = newValue
        }
    }

    
    /// Indicator göster
    func showHud(){
        if !hud.isDescendant(of: self) {
            hud = MBProgressHUD.showAdded(to: self, animated: true)
            hud.mode = .indeterminate
            hud.label.text = nil
        }
    }
    
    /// Indicator gizle
    func hideHud(){
        DispatchQueue.main.async {
            if self.hud.isDescendant(of: self) {
                MBProgressHUD.hide(for: self, animated: true)
            }
        }
    }
}
