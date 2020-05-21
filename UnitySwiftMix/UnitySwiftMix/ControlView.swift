//
//  ControlView.swift
//  UnitySwiftMix
//
//  Created by xu on 2019/11/21.
//  Copyright © 2019 tech. All rights reserved.
//

import UIKit

class ControlView: UIView {
    
    @IBAction func changeColor(_ sender: UIButton) {
        var string = "red"
        if sender.tag == 1 {
            string = "blue"
        }else if sender.tag == 2 {
            string = "yellow"
        }
        UnityEmbeddedSwift.sendUnityMessage(UnityEmbeddedSwift.UnityMessage(objectName: "Cube", methodName: "ChangeColor", messageBody: string))
    }
    
}
