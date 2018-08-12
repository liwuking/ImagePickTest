//
//  YImageCell.swift
//  ImagePickTest
//
//  Created by user on 2018/8/11.
//  Copyright © 2018年 liwuyang. All rights reserved.
//

import UIKit
import SnapKit
class YImageCell: UICollectionViewCell {
    
    static let identifier = "YImageCell"
    var imageView:UIImageView!
    var selectBtn:UIButton!
    var selectBtnBlock:(()->())?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        self.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        selectBtn = UIButton()
        self.addSubview(selectBtn)
        selectBtn.setImage(#imageLiteral(resourceName: "ic_unchoose"), for: .normal)
        selectBtn.addTarget(self, action: #selector(clickSelectBtn), for: .touchUpInside)
        selectBtn.snp.makeConstraints { (make) in
            make.trailing.top.equalToSuperview()
            make.width.height.equalTo(28)
        }
        
    }
    
    @objc func clickSelectBtn() {
        self.selectBtnBlock?()
    }
    func setData(model:YAssetModel) {
        imageView.image = model.thumImage
        if model.isSelected {
            selectBtn.setImage(#imageLiteral(resourceName: "ic_choose"), for: .normal)
        } else {
            selectBtn.setImage(#imageLiteral(resourceName: "ic_unchoose"), for: .normal)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
