//
//  ViewController.swift
//  QRCodeProject
//
//  Created by 曾政桦 on 2018/1/21.
//  Copyright © 2018年 隐贞. All rights reserved.
//

import UIKit
import QRCodeReader

class ViewController: UIViewController {
    
    lazy var scanButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 30, y: 250, width: 80, height: 30)
        button.setTitle("scan", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(scanButtonClick), for: .touchUpInside)
        return button
    }()
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder { builderT in
            let scanView = QRScanView()
            scanView.setupComponents(showCancelButton: true, showSwitchCameraButton: false, showTorchButton: false, showOverlayView: true, reader: QRCodeReader()) 
            
            let readerView = QRCodeReaderContainer(displayable: scanView)
            builderT.showSwitchCameraButton = false
            builderT.readerView = readerView
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        readerVC.delegate = self
        view.addSubview(scanButton)
    }
    
    @objc func scanButtonClick() {
        present(readerVC, animated: true, completion: nil)
    }
}

extension ViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        print(result.value)
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

