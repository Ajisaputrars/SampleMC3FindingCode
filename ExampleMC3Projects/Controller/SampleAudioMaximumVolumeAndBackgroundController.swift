//
//  ViewController.swift
//  ExampleMC3Projects
//
//  Created by Aji Saputra Raka Siwi on 28/07/20.
//  Copyright © 2020 Aji Saputra Raka Siwi. All rights reserved.
//

import UIKit
import AVFoundation

class SampleAudioMaximumVolumeAndBackgroundController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    
    let sampleAudioButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.setTitle("Sample Maximum Audio", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(sampleAudioButton)
        
        self.sampleAudioButton.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        
        self.title = "Sample Audio"
        
        self.sampleAudioButton.addTarget(self, action: #selector(playSampleAudio), for: .touchUpInside)
    }
    
    @objc
    private func playSampleAudio() {
        do {
            let soundURL = URL(fileURLWithPath: Bundle.main.path(forResource: "audiosample", ofType: "m4a")!)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = 10
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}