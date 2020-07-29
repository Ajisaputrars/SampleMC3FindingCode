//
//  SampleFlashLightController.swift
//  ExampleMC3Projects
//
//  Created by Aji Saputra Raka Siwi on 29/07/20.
//  Copyright © 2020 Aji Saputra Raka Siwi. All rights reserved.
//

import UIKit
import AVFoundation

class SampleFlashLightController: UIViewController {
    
    var timer: Timer!
    
    let sampleFlashButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Sample Flash", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(sampleFlashButton)
        
        self.sampleFlashButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        
        self.title = "Sample Flash"
        
        self.sampleFlashButton.addTarget(self, action: #selector(playTorch), for: .touchUpInside)
    }
    
    @objc
    private func playTorch(){
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
        }
        
        // MARK: Background Timer, still not working for Torch mode
        
        //        var bgTask = UIBackgroundTaskIdentifier(rawValue: 10)
        //        bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
        //            UIApplication.shared.endBackgroundTask(bgTask)
        //        })
        
        self.timer = Timer()
        self.timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(playSampleFlash), userInfo: nil, repeats: true)
    }
    
    @objc
    private func playSampleFlash(){
        guard let device = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        guard device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            
            if (device.torchMode == AVCaptureDevice.TorchMode.on) {
                device.torchMode = AVCaptureDevice.TorchMode.off
            } else {
                do {
                    try device.setTorchModeOn(level: 1.0)
                } catch {
                    print(error)
                }
            }
            device.unlockForConfiguration()
        } catch {
            print(error)
        }
    }
}
