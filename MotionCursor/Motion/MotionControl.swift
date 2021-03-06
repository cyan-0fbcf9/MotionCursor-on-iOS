//
//  MotionControl.swift
//  MotionCursor
//
//  Created by NH on 2020/08/28.
//  Copyright © 2020 NH. All rights reserved.
//

import Foundation
import CoreMotion

class MotionControl {
    
    let controllable: MotionControllable
    let queue: OperationQueue
    let FPS: Double = 30
    
    init(controllable: MotionControllable) {
        self.controllable = controllable
        self.queue = OperationQueue.init()
    }
    
    // MARK: - Motion Contents
    func startListeningMotion() {
        if self.controllable.motionManager.isDeviceMotionAvailable {
            self.controllable.motionManager.deviceMotionUpdateInterval = 1.0 / FPS
            self.controllable.motionManager.startDeviceMotionUpdates(to: queue) { (motionOptional, error) in
                if let e = error {
                    print("error on [Start DeviceMotionUpdates]", e)
                    return
                }
                
                guard let motion = motionOptional else {
                    print("motion is null")
                    return
                }
                
                self.controllable.onMotion(deviceMotion: motion)
            }
            
        } else {
            print("this device is not motion active")
        }
    }
    
    func stopListeningMotion() {
        self.controllable.motionManager.stopDeviceMotionUpdates()
    }
}
