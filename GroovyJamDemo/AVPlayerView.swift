//
//  AVPlayerView.swift
//  GroovyJamDemo
//
//  Created by Kurose Nobuhito on 2015/02/28.
//  Copyright (c) 2015年 Kurose Nobuhito. All rights reserved.
//

import AVFoundation
import UIKit

// レイヤーをAVPlayerLayerにする為のラッパークラス.
class AVPlayerView : UIView{
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override class func layerClass() -> AnyClass{
        return AVPlayerLayer.self
    }
    
}