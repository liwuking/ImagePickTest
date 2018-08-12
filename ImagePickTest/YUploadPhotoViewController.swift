//
//  YUploadPhotoViewController.swift
//  ImagePickTest
//
//  Created by user on 2018/8/11.
//  Copyright © 2018年 liwuyang. All rights reserved.
//

import UIKit
import Photos
class YUploadPhotoViewController: UIViewController {

    ///取得的资源结果，用了存放的PHAsset
    var assetsFetchResults:PHFetchResult<PHAsset>?
    
    let _columnNumber = 4
    let itemMargin:CGFloat = 5
    var _layout:UICollectionViewFlowLayout!
    var _collectionView:UICollectionView!
    var _models:[YAssetModel] = []
    var selectedArr:[YAssetModel] = []
    var maxSelectedNum:Int = 10
    var _uploadLab:UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
        //申请权限
        PHPhotoLibrary.requestAuthorization({ (status) in
            if status != .authorized {
                return
            }
            
            let assetModels:[YAssetModel] = self.fetchPhotos()
            if assetModels.count > 0 {
                self._models.removeAll()
                self._models.append(contentsOf: assetModels)
            }
    
            //collection view 重新加载数据
            DispatchQueue.main.async{
                self._collectionView?.reloadData()
            }
        })
    }
    
    func fetchPhotos() -> [YAssetModel] {
        //则获取所有资源
        let allPhotosOptions = PHFetchOptions()
        //按照创建时间倒序排列
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                             ascending: false)]
        //只获取图片
        allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                 PHAssetMediaType.image.rawValue)
        self.assetsFetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.image,
                                                      options: allPhotosOptions)
        
        var assetModels:[YAssetModel] = []
        if let assets = self.assetsFetchResults {
            let scale = UIScreen.main.scale
            let cellSize = self._layout.itemSize
            let assetGridThumbnailSize = CGSize(width:cellSize.width*scale ,
                                                height:cellSize.height*scale)
            for index in 0..<assets.count {
                let model:YAssetModel = YAssetModel()
                model.asset = assets[index]
                model.assetGridThumbnailSize = assetGridThumbnailSize
                assetModels.append(model)
            }
        }
        return assetModels
    }
    
    func buildNav() {
        let navigaView = UIView()
        navigaView.backgroundColor = UIColor.init(rgb: 0xFFF8F8F8)
        self.view.addSubview(navigaView)
        self.view.bringSubview(toFront: navigaView)
        navigaView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(64+isIphoneXHaveHeadHeight)
        }
        self.view.layoutIfNeeded()
        
        let backBtn = UIButton()
        backBtn.setImage(#imageLiteral(resourceName: "ic_title_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        navigaView.addSubview(backBtn)
        backBtn.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(0)
            make.bottom.equalToSuperview()
            make.width.equalTo(56)
            make.height.equalTo(44)
        }
        
        let titleLabel = UILabel()
        titleLabel.font = Font18
        titleLabel.textColor = UIColor.init(rgb: 0xCC000000)
        titleLabel.textAlignment = .center
        titleLabel.text = LocalizedString("Album")
        navigaView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(44)
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.init(rgb: 0x0D272302)
        self.view.addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @objc func backBtnAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func initUI() {
        
        self.buildNav()
        
        _layout = UICollectionViewFlowLayout()
        
        let itemWH = (Screen_Width - (CGFloat(_columnNumber) + 1) * itemMargin) / CGFloat(_columnNumber)
        _layout.itemSize = CGSize(width: itemWH, height: itemWH)
        _layout.minimumInteritemSpacing = itemMargin
        _layout.minimumLineSpacing = itemMargin
        
        _collectionView = UICollectionView(frame: .zero, collectionViewLayout: _layout)
        self.view.addSubview(_collectionView)
        _collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64+isIphoneXHaveHeadHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        _collectionView.backgroundColor = UIColor.white
        _collectionView.dataSource = self
        _collectionView.delegate = self
        _collectionView.alwaysBounceHorizontal = false
        _collectionView.contentInset = UIEdgeInsetsMake(itemMargin, itemMargin, itemMargin, itemMargin)
        _collectionView.register(YImageCell.self, forCellWithReuseIdentifier: YImageCell.identifier)
        
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
                self.changeSelectButtonStateAtIndex(index: index, photoModel: assetModel)
                self.selectedArr.insert(assetModel, at: self.selectedArr.count)
                //变动选择的照片张数目
                self.updateSelectedPhotoNum()
            }
        } else {
            assetModel.isSelected = false
            self.changeSelectButtonStateAtIndex(index: index, photoModel: assetModel)
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
    func changeSelectButtonStateAtIndex(index:Int,photoModel:YAssetModel) {
        let cell = _collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as! YImageCell
        cell.setData(model: photoModel)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


extension YUploadPhotoViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return _models.count
        return _models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YImageCell.identifier, for: indexPath) as! YImageCell
        let model = _models[indexPath.row]
        cell.setData(model: model)
        cell.selectBtnBlock = {[weak self] in
            guard let `self` = self else {
                return
            }
            self.selectPhotoAtIndex(index: indexPath.row)
        }
        return cell
    }
}

extension YUploadPhotoViewController:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoPreviewViewController = YUploadPhotoPreviewViewController()
        photoPreviewViewController._models = _models
        photoPreviewViewController.selectedArr = self.selectedArr
        photoPreviewViewController._currentIndex = indexPath.row
        photoPreviewViewController.maxSelectedNum = self.maxSelectedNum
        self.navigationController?.pushViewController(photoPreviewViewController, animated: true)
        
        photoPreviewViewController.navBack = {[weak self] arr in
            guard let `self` = self else {
                return
            }
            self.selectedArr = arr
            self._collectionView.reloadData()
            self.updateSelectedPhotoNum()
        }
    }
}




