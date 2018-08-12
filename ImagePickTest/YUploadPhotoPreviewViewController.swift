//
//  YUploadPhotoPreviewViewController.swift
//  ImagePickTest
//
//  Created by user on 2018/8/12.
//  Copyright © 2018年 liwuyang. All rights reserved.
//

import UIKit

class YUploadPhotoPreviewViewController: UIViewController {

    var _navView:UIView!
    let _columnNumber = 1
    let itemMargin:CGFloat = 0
    var _layout:UICollectionViewFlowLayout!
    var _collectionView:UICollectionView!
    var _models:[YAssetModel] = []
    var selectedArr:[YAssetModel] = []
    var _currentIndex = 0
    var maxSelectedNum:Int = 10
    var _uploadLab:UILabel!
    var _titleLabel:UILabel!
    var _selectNavBtn:UIButton!
    
    var navBack:(([YAssetModel])->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initUI()
    }
    
    func buildNav() {
        _navView = UIView()
        _navView.backgroundColor = UIColor.init(rgb: 0x4D000000)
        self.view.addSubview(_navView)
        _navView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(64+isIphoneXHaveHeadHeight)
        }
        
        let backBtn = UIButton()
        backBtn.setImage(#imageLiteral(resourceName: "ic_title_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        _navView.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(0)
            make.bottom.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(44)
        }
        
        _titleLabel = UILabel()
        _titleLabel.font = VideoShowFont().fontWithSizeRobotoRegular(size: 18)
        _titleLabel.textColor = UIColor.init(rgb: 0xCCFFFFFF)
        _titleLabel.textAlignment = .center
        _titleLabel.text = "\(_currentIndex+1)/\(_models.count)"
        _navView.addSubview(_titleLabel)
        _titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        _selectNavBtn = UIButton()
        _navView.addSubview(_selectNavBtn)
        _selectNavBtn.setImage(#imageLiteral(resourceName: "ic_unchoose"), for: .normal)
        _selectNavBtn.addTarget(self, action: #selector(clickSelectBtn), for: .touchUpInside)
        _selectNavBtn.snp.makeConstraints { (make) in
            make.trailing.bottom.equalToSuperview()
            make.width.height.equalTo(52)
        }
        
        
    }
    
    
    @objc func clickSelectBtn() {
        self.selectPhotoAtIndex(index: _currentIndex)
    }
    
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navBack?(selectedArr)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _collectionView.layoutIfNeeded()
        _collectionView.scrollToItem(at: IndexPath(row: _currentIndex, section: 0), at: .centeredHorizontally, animated: false)
        self.updateSelectedPhotoNum()
    }
    func initUI() {
        
        self.buildNav()
        
        _layout = UICollectionViewFlowLayout()
        _layout.itemSize = CGSize(width: Screen_Width, height: Screen_Height)
        _layout.scrollDirection = .horizontal
        _layout.minimumInteritemSpacing = 0
        _layout.minimumLineSpacing = 0
        
        _collectionView = UICollectionView(frame: .zero, collectionViewLayout: _layout)
        self.view.insertSubview(_collectionView, belowSubview: _navView)
        
        _collectionView.snp.makeConstraints { (make) in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        _collectionView.backgroundColor = UIColor.white
        _collectionView.dataSource = self
        _collectionView.delegate = self
        _collectionView.isDirectionalLockEnabled = true
        _collectionView.alwaysBounceHorizontal = true
        _collectionView.showsHorizontalScrollIndicator = false
        _collectionView.isPagingEnabled = true
//        _collectionView.contentInset = UIEdgeInsetsMake(itemMargin, itemMargin, itemMargin, itemMargin)
        _collectionView.register(YPreviewImageCell.self, forCellWithReuseIdentifier: YPreviewImageCell.identifier)
        
        
        let bottomView = UIView()
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        bottomView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        
        _uploadLab = UILabel()
        bottomView.addSubview(_uploadLab)
        _uploadLab.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(126)
            make.height.equalTo(32)
        }
        _uploadLab.backgroundColor = UIColor.init(rgb: 0xFFB2B2B2)
        _uploadLab.clipsToBounds = true
        _uploadLab.layer.cornerRadius = 16
        _uploadLab.font = VideoShowFont().fontWithSizeRobotoMedium(size: 14)
        _uploadLab.textColor = UIColor.white
        _uploadLab.textAlignment = .center
        _uploadLab.text = "Upload(0)"
        let tagGes = UITapGestureRecognizer(target: self, action: #selector(clickUploadBtn))
        _uploadLab.addGestureRecognizer(tagGes)
        
        
    }
    
    @objc func clickUploadBtn() {
        if self.selectedArr.count <= 0 {
            return
        }
    }
    
    func selectPhotoAtIndex(index:Int) {
        let assetModel = _models[index]
        if assetModel.isSelected == false {
            if self.selectedArr.count >= maxSelectedNum {
                //提醒最大选择几张图片
            } else {
                assetModel.isSelected = true
                _selectNavBtn.setImage(#imageLiteral(resourceName: "ic_choose"), for: .normal)
                self.selectedArr.insert(assetModel, at: self.selectedArr.count)
                //变动选择的照片张数目
                self.updateSelectedPhotoNum()
            }
        } else {
            assetModel.isSelected = false
            _selectNavBtn.setImage(#imageLiteral(resourceName: "ic_unchoose"), for: .normal)
            if let ind = self.selectedArr.index(of: assetModel) {
                self.selectedArr.remove(at: ind)
            }
            //变动选择的照片张数目
            self.updateSelectedPhotoNum()
        }
    }
    
    func updateSelectedPhotoNum() {
        if self.selectedArr.count <= 0 {
            _uploadLab.backgroundColor = UIColor.init(rgb: 0xFFB2B2B2)
            _uploadLab.text = "upload(0)"
        } else {
            _uploadLab.backgroundColor = UIColor.init(rgb: 0xFFCA16FF)
            _uploadLab.text = "upload(\(self.selectedArr.count))"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension YUploadPhotoPreviewViewController:UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.x)
        _currentIndex = Int(scrollView.contentOffset.x / Screen_Width)
        _titleLabel.text = "\(_currentIndex+1)/\(_models.count)"
        let model = _models[_currentIndex]
        if model.isSelected {
            _selectNavBtn.setImage(#imageLiteral(resourceName: "ic_choose"), for: .normal)
        } else {
            _selectNavBtn.setImage(#imageLiteral(resourceName: "ic_unchoose"), for: .normal)
        }
    }
}

extension YUploadPhotoPreviewViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return _models.count
        return _models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YPreviewImageCell.identifier, for: indexPath) as! YPreviewImageCell
        let model = _models[indexPath.row]
        cell.setData(model: model)
        if model.isSelected {
            _selectNavBtn.setImage(#imageLiteral(resourceName: "ic_choose"), for: .normal)
        } else {
            _selectNavBtn.setImage(#imageLiteral(resourceName: "ic_unchoose"), for: .normal)
        }
//        cell.selectBtnBlock = {[weak self] in
//            guard let `self` = self else {
//                return
//            }
//            self.selectPhotoAtIndex(index: indexPath.row)
//        }
        return cell
    }
}

extension YUploadPhotoPreviewViewController:UICollectionViewDelegate {
    
}
