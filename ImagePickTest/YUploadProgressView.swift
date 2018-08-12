//
//  YUploadProgressView.swift
//  ImagePickTest
//
//  Created by user on 2018/8/12.
//  Copyright © 2018年 liwuyang. All rights reserved.
//

import UIKit

class YUploadProgressView: UIView {

    fileprivate var _progressLab:UILabel!
    fileprivate var _progressView:UIProgressView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        self.initUI()
    }
    
    func initUI() {
        let leftLab = UILabel()
        self.addSubview(leftLab)
        leftLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(16)
        }
        leftLab.text = "Uploading..."
        leftLab.font = VideoShowFont().fontWithSizeRobotoRegular(size: 14)
        leftLab.textColor = UIColor.init(rgb: 0xCC000000)
        leftLab.backgroundColor = UIColor.clear
        self.addSubview(leftLab)
        
        _progressLab = UILabel()
        self.addSubview(_progressLab)
        _progressLab.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(16)
        }
        _progressLab.font = VideoShowFont().fontWithSizeRobotoRegular(size: 14)
        _progressLab.textColor = UIColor.init(rgb: 0xCC000000)
        _progressLab.backgroundColor = UIColor.clear
        self.addSubview(_progressLab)
        
        _progressView = UIProgressView(progressViewStyle: .default)
        self.addSubview(_progressView)
        _progressView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
        }
        _progressView.progressTintColor = UIColor.init(rgb: 0xFF7DBE00)
        _progressView.trackTintColor = UIColor.clear
        _progressView.progress = 0
        
    }
    
    func updateProgress(totalNum:Int,uploadedNum:Int) {
        _progressLab.text = "\(uploadedNum)/\(totalNum)"
        let progress = Float(uploadedNum)/Float(totalNum)
        _progressView.progress = progress
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
