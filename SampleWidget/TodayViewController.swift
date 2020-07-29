//
//  TodayViewController.swift
//  SampleWidget
//
//  Created by Aji Saputra Raka Siwi on 29/07/20.
//  Copyright © 2020 Aji Saputra Raka Siwi. All rights reserved.
//

import UIKit
import NotificationCenter
import SnapKit

class TodayViewController: UIViewController, NCWidgetProviding {
    
    let sampleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Label"
        label.backgroundColor = .green
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.sampleLabel)
        
        self.sampleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.view).offset(8)
            make.right.bottom.equalTo(self.view).offset(-8)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tryPressLabel))
        self.sampleLabel.addGestureRecognizer(tapGesture)
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    @objc
    private func tryPressLabel(){
        let url = URL(string: "ExampleMC3Projects://")!
        self.extensionContext?.open(url, completionHandler: nil)
    }
}
