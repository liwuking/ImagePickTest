/*
	Copyright (C) 2017 Apple Inc. All Rights Reserved.
	See LICENSE.txt for this sample’s licensing information
	
	Abstract:
	Collection view cell for displaying an asset.
 */


import UIKit

class GridViewCell: UICollectionViewCell {

     var imageView: UIImageView!
     var livePhotoBadgeImageView: UIImageView!

    var representedAssetIdentifier: String!

    override convenience init(frame: CGRect) {
        self.init(frame: frame)
        imageView = UIImageView()
        imageView.frame = self.frame
        livePhotoBadgeImageView = UIImageView()
//        livePhotoBadgeImage.frame = c
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var thumbnailImage: UIImage! {
        didSet {
            imageView.image = thumbnailImage
        }
    }
    var livePhotoBadgeImage: UIImage! {
        didSet {
            livePhotoBadgeImageView.image = livePhotoBadgeImage
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        livePhotoBadgeImageView.image = nil
    }
}
