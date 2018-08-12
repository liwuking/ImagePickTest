//
//  ViewController.swift
//  ImagePickTest
//
//  Created by user on 2018/8/11.
//  Copyright © 2018年 liwuyang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = UIColor.white
        let vc = YUploadPhotoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
//        let bottomProgressView = YUploadProgressView()
//        self.view.addSubview(bottomProgressView)
//        bottomProgressView.snp.makeConstraints { (make) in
//            make.leading.trailing.bottom.equalToSuperview()
//            make.height.equalTo(36)
//        }
//        bottomProgressView.updateProgress(totalNum: 25, uploadedNum: 15)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

