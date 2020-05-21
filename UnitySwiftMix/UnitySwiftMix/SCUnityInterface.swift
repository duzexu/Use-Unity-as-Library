//
//  SCUnityInterface.swift
//  UnitySwiftMix
//
//  Created by xu on 2019/11/21.
//  Copyright © 2019 tech. All rights reserved.
//

import UIKit
import CoreMedia

class SCUnityInterface: NSObject, NativeCallsProtocol {
    
    static let instance = SCUnityInterface()
    
    override init() {
        super.init()
    }
    
}

extension SCUnityInterface {
    func showHostMainWindow(_ color: String) {
        if let root = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            let view = ViewController()
            root.pushViewController(view, animated: true)
        }else{
            let vc = UnityEmbeddedSwift.unityViewController()
            UIApplication.shared.keyWindow?.rootViewController = nil
            let nav = UINavigationController(rootViewController: vc!)
            nav.isNavigationBarHidden = true
            UIApplication.shared.keyWindow?.rootViewController = nav
            let control = Bundle.main.loadNibNamed("ControlView", owner: nil, options: nil)?.last as? UIView
            control?.frame = UIScreen.main.bounds
            vc?.view.addSubview(control!)
            let view = ViewController()
            nav.pushViewController(view, animated: true)
        }
    }
}
