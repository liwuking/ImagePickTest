//
//  YAssetModel.swift
//  ImagePickTest
//
//  Created by user on 2018/8/11.
//  Copyright © 2018年 liwuyang. All rights reserved.
//

import UIKit
import Photos
class YAssetModel: NSObject {
    var isSelected = false
    
    var asset:PHAsset?
    var originImage:UIImage? {
        get {
            guard let phasset = asset else {
                return nil
            }
            return  self.fetchOriginalImageWithAsset(asset: phasset)
        }
    }
    var imageUrl:NSURL?
    var assetGridThumbnailSize:CGSize!
    var thumImage:UIImage? {
        get {
            guard let phasset = asset else {
                return nil
            }
            return  self.fetchThumbImageWithAsset(asset: phasset)
        }
    }
    
    func fetchThumbImageWithAsset(asset:PHAsset) -> UIImage {
        var thumbImage:UIImage?
        
        PHImageManager.default().requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: .aspectFill, options: nil) { (image,info) in
            thumbImage = image
        }
        
        return thumbImage!
    }
    func fetchOriginalImageWithAsset(asset:PHAsset) -> UIImage? {
        var originImage:UIImage?
        
        let photoWidth = Screen_Width
        var screenScale:CGFloat = 2.0
        if (photoWidth > 700) {
            screenScale = 1.5
        }
        
        let aspectRatio:CGFloat = CGFloat(asset.pixelWidth / asset.pixelHeight)
        let pixelWidth:CGFloat = photoWidth * screenScale
        let pixelHeight:CGFloat = pixelWidth / aspectRatio
        let imageSize = CGSize(width: pixelWidth, height: pixelHeight)
        
        let option = PHImageRequestOptions()
        option.resizeMode = .fast
        option.isSynchronous = true
        
        PHImageManager.default().requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: option) { (image,info) in
            originImage = image
        }
        
        return originImage
    }
}
