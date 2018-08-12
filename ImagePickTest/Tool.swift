//
//  Tool.swift
//  scrollowInsetTest
//
//  Created by lbe on 2018/8/10.
//  Copyright © 2018年 liwuyang. All rights reserved.
//

import UIKit

func userInterfaceFromRightToLeft()->Bool{
    if IOS_VER >= 9 {
        return UIView.appearance().semanticContentAttribute == .forceRightToLeft
    }else{
        return false
    }
}

/**
 *  系统参数
 */
public let IOS_VER = (UIDevice.current.systemVersion as NSString).doubleValue
public let IS_IOS7 = ((IOS_VER>=7.0) && (IOS_VER<8.0))
public let IS_IOS8 = ((IOS_VER>=8.0) && (IOS_VER<9.0))
public let IS_IOS9 = ((IOS_VER>=9.0) && (IOS_VER<10.0))
public let IS_IOS10 = ((IOS_VER>=10.0) && (IOS_VER<11.0))
public let IS_iOS9_LATER = (IOS_VER >= 9.0)
public let IS_iOS10_LATER = (IOS_VER >= 10.0)

/**
 *  屏幕参数
 */
public let Screen_Scale = UIScreen.main.scale
public let Screen_Bounds = UIScreen.main.bounds
public let Screen_Width = Screen_Bounds.size.width
public let Screen_Height = Screen_Bounds.size.height

/**
 *  效果图缩放比
 */
public let SCREEN_RATE = Screen_Width/360
public let SCREEN_RATE_W = Screen_Width/360
public let SCREEN_RATE_H = Screen_Height/640
/**
 * 设备型号
 */
public let IS_iPhone4_4s = (Screen_Height==480)
public let IS_iPhone5_5s = (Screen_Height==568)
public let IS_iPhone6_6s = (Screen_Height==667)
public let IS_iPhone6p = (Screen_Height==736)
public let IS_iPhoneX = (Screen_Height==812)
public let IS_Width_320 = (Screen_Width == 320)
public let isIphoneXHaveHeadHeight:CGFloat = IS_iPhoneX ? 24.0:0.0
public let isIphoneXHaveBottomHeight:CGFloat = IS_iPhoneX ? 34.0:0.0

public let isIphoneXminHeight:CGFloat = IS_iPhoneX ? 14:0

public let IS_STANDARD_ENV = "IS_STANDARD_ENV"

func LocalizedString(_ keyStr:String?) -> String {
    //    return  keyStr != nil ? NSLocalizedString(keyStr!, tableName: "VideoShowLocalizable" ,comment: "") : ""
    return keyStr ?? " "
    
}

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0 ,
                  green: CGFloat((rgb & 0xFF00) >> 8) / 255.0 ,
                  blue: CGFloat((rgb & 0xFF)) / 255.0 ,
                  alpha: CGFloat((rgb & 0xFF000000) >> 24) / 255.0
        )
    }
}

// RGBA的颜色设置
public func RGBA (_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
// HSBA的颜色设置
public func HSBA (_ h:CGFloat, s:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor(hue: h/360, saturation: s/100, brightness: b/100, alpha: a)
}


let Font1           = VideoShowFont().fontWithSizeMedium(size:20)
let Font2           = VideoShowFont().fontWithSizeMedium(size:18)
let Font3           = VideoShowFont().fontWithSizeMedium(size:16)
let Font4           = VideoShowFont().fontWithSizeBold(size:16)
let Font5           = VideoShowFont().fontWithSizeMedium(size:14)
let Font6           = VideoShowFont().fontWithSizeMedium(size:12)
let Font7           = VideoShowFont().fontWithSizeMedium(size:10)

let Font20           = VideoShowFont().fontWithSizeMedium(size:20)
let Font18           = VideoShowFont().fontWithSizeMedium(size:18)
let Font16           = VideoShowFont().fontWithSizeMedium(size:16)
let Font16_B         = VideoShowFont().fontWithSizeBold(size:16)
let Font14           = VideoShowFont().fontWithSizeMedium(size:14)
let Font14_B         = VideoShowFont().fontWithSizeBold(size:14)
let Font12           = VideoShowFont().fontWithSizeMedium(size:12)
let Font10           = VideoShowFont().fontWithSizeMedium(size:10)

let LightFontColor_Primary = UIColor.init(rgb: 0xCC000000)
let LightFontColor_Secondary = UIColor.init(rgb: 0x99000000)
let LightFontColor_Disabled = UIColor.init(rgb: 0x66000000)

let DeepFontColor_Primary = UIColor.init(rgb: 0xFFFFFFFF)
let DeepFontColor_Secondary = UIColor.init(rgb: 0x66FFFFFF)

let OtherFontColor_Secondary = UIColor.init(rgb: 0xFF7840FB)

let BackgroundColor = RGBA(36, g: 33, b: 50, a: 1)

class VideoShowFont: UIFont {
    func fontWithSizeNormal(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue", size: size)!
    }
    
    func fontWithSizeMedium(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue-Medium", size: size)!
    }
    
    func fontWithSizeLight(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue-Light", size: size)!
    }
    
    func fontWithSizeBold(size: CGFloat) -> UIFont{
        return UIFont(name: "HelveticaNeue-Bold", size: size)!
    }
    func fontWithSizeRobotoMedium(size: CGFloat) -> UIFont {
        return UIFont.init(name: "HelveticaNeue-Medium", size: size)!
    }
    func fontWithSizeRobotoRegular(size: CGFloat) -> UIFont {
        return UIFont.init(name: "HelveticaNeue", size: size)!
    }
}


class Tool: NSObject {

}
