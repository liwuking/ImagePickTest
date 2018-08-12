//
//  YPreviewImageCell.swift
//  ImagePickTest
//
//  Created by user on 2018/8/12.
//  Copyright © 2018年 liwuyang. All rights reserved.
//

import UIKit

class YPreviewImageCell: UICollectionViewCell {
    static let identifier = "YPreviewImageCell"
    var imageView:UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    func setData(model:YAssetModel) {
        imageView.image = model.originImage
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
