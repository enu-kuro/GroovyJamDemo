//
//  ViewController.swift
//  GroovyJamDemo
//
//  Created by Kurose Nobuhito on 2015/02/28.
//  Copyright (c) 2015年 Kurose Nobuhito. All rights reserved.
//


import UIKit
import AVFoundation
import CoreMedia

class ViewController2: UIViewController {
    
    var videoPlayer : AVPlayer!

    var aVPlayerLayer:AVPlayerLayer!
    
    var panGestureRecognizer:UIPanGestureRecognizer!
    
    var isLocked = false
    
    var movieTitleArray:[String] = ["Shiggy Jr. - Saturday night to Sunday morning","Breakbot - Baby I'm Yours feat. Irfane","denpa_sakura","tokyojihen"]
    var movieStartPositionArray:[Double] = [51.6, 80, 100, 42]
    var playerItemArray:[AVPlayerItem] = [AVPlayerItem]()
    var videoViewArray = [UIView]()
    var VideoViewPositionArray:[CGPoint] = [CGPointMake(6.0,54.0),CGPointMake(6.0,422.0),CGPointMake(4.0,769.0),CGPointMake(6.0,1146.0)]
    
    var currentPlayingIndex = 0
    var startButton:UIButton!
    var startButton2:UIButton!
    
    var player : AVAudioPlayer!
    
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var videoView1: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    var originalVideoFrame:CGRect = CGRectZero
    var originalVideoPoint:CGPoint = CGPointZero
    
    let blackView = UIView()
    
    //@IBOutlet weak var lockedLabel: UILabel!
    override func viewDidLoad() {
        
        
        
        
        let path = NSBundle.mainBundle().pathForResource(movieTitleArray[0], ofType: "mov")
        let fileURL = NSURL(fileURLWithPath: path!)
        let avAsset = AVURLAsset(URL: fileURL, options: nil)
        
        var playerItem = AVPlayerItem(asset: avAsset)
        playerItemArray.append(playerItem)
        
        
        let path2 = NSBundle.mainBundle().pathForResource(movieTitleArray[1], ofType: "mov")
        let fileURL2 = NSURL(fileURLWithPath: path2!)
        let avAsset2 = AVURLAsset(URL: fileURL2, options: nil)
        
        
        var playerItem2 = AVPlayerItem(asset: avAsset2)
        playerItemArray.append(playerItem2)
        
        
        let path3 = NSBundle.mainBundle().pathForResource(movieTitleArray[2], ofType: "mov")
        let fileURL3 = NSURL(fileURLWithPath: path3!)
        let avAsset3 = AVURLAsset(URL: fileURL3, options: nil)
        
        var playerItem3 = AVPlayerItem(asset: avAsset3)
        playerItemArray.append(playerItem3)
        
        
        
        let path4 = NSBundle.mainBundle().pathForResource(movieTitleArray[3], ofType: "mov")
        let fileURL4 = NSURL(fileURLWithPath: path4!)
        let avAsset4 = AVURLAsset(URL: fileURL4, options: nil)
        
        var playerItem4 = AVPlayerItem(asset: avAsset4)
        playerItemArray.append(playerItem4)
        
        
        videoPlayer = AVPlayer(playerItem: playerItem)
        
        self.videoView1.frame = CGRect(x: 0, y: 0, width: 360, height: 200)
        let videoPlayerView = AVPlayerView(frame: self.videoView1.bounds)
        println(self.videoView1.bounds)
        
        aVPlayerLayer = videoPlayerView.layer as AVPlayerLayer
        aVPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect
        aVPlayerLayer.player = videoPlayer
        
        self.videoView1.layer.addSublayer(aVPlayerLayer)
        
        videoView1.alpha = 0
        originalVideoFrame = aVPlayerLayer.frame
        originalVideoPoint = aVPlayerLayer.position
        
        aVPlayerLayer.anchorPoint = CGPointMake(0.5, 0.5)
        aVPlayerLayer.frame = CGRectMake(aVPlayerLayer.frame.origin.x, aVPlayerLayer.frame.origin.y, 0, 0)
        aVPlayerLayer.position = originalVideoPoint
        
        button0.addTarget(self, action: "touchDown:", forControlEvents: UIControlEvents.TouchDown)
        button0.addTarget(self, action: "touchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        button0.addTarget(self, action: "touchUpOutside:", forControlEvents: UIControlEvents.TouchUpOutside)
        button0.addTarget(self, action: "touchCancel:", forControlEvents: UIControlEvents.TouchCancel)
        
        button1.addTarget(self, action: "touchDown:", forControlEvents: UIControlEvents.TouchDown)
        button1.addTarget(self, action: "touchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        button1.addTarget(self, action: "touchUpOutside:", forControlEvents: UIControlEvents.TouchUpOutside)
        button1.addTarget(self, action: "touchCancel:", forControlEvents: UIControlEvents.TouchCancel)
        
        button2.addTarget(self, action: "touchDown:", forControlEvents: UIControlEvents.TouchDown)
        button2.addTarget(self, action: "touchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        button2.addTarget(self, action: "touchUpOutside:", forControlEvents: UIControlEvents.TouchUpOutside)
        button2.addTarget(self, action: "touchCancel:", forControlEvents: UIControlEvents.TouchCancel)
        
        button3.addTarget(self, action: "touchDown:", forControlEvents: UIControlEvents.TouchDown)
        button3.addTarget(self, action: "touchUpInside:", forControlEvents: UIControlEvents.TouchUpInside)
        button3.addTarget(self, action: "touchUpOutside:", forControlEvents: UIControlEvents.TouchUpOutside)
        button3.addTarget(self, action: "touchCancel:", forControlEvents: UIControlEvents.TouchCancel)
        
        
        panGestureRecognizer = UIPanGestureRecognizer(target:self, action:"panGesture:")
        panGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        
        //lockedLabel.hidden = true
        
        //backgroundでBGM鳴らしたい場合はこれ使う
        //        let audioPath = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bgm_title", ofType: "mp3")!)
        //
        //        player = AVAudioPlayer(contentsOfURL: audioPath, error: nil)
        //        player.prepareToPlay()
        
        blackView.frame = self.scrollView.frame
        blackView.backgroundColor = UIColor.whiteColor()
        blackView.alpha = 0
        self.scrollView.insertSubview(blackView, aboveSubview: mainImageView)
        
        
    }
    
    func touchDown(sender : UIButton){

        if sender == button0{
            currentPlayingIndex = 0
        }else if sender == button1{
            currentPlayingIndex = 1
        }else if sender == button2{
            currentPlayingIndex = 2
        }else if sender == button3{
            currentPlayingIndex = 3
        }
        println(currentPlayingIndex)
        videoView1.frame.origin = VideoViewPositionArray[currentPlayingIndex]
        videoPlayer.replaceCurrentItemWithPlayerItem(playerItemArray[currentPlayingIndex])
        
        videoPlayer.seekToTime(CMTimeMakeWithSeconds(Float64(movieStartPositionArray[currentPlayingIndex]), Int32(NSEC_PER_SEC)))
        videoPlayer.play()
        
        showVideoAnim()
    }
    
    func touchEventEnded(){
        videoPlayer.pause()
        
        closeVideoAnim()
        
        let delay = 0.2 * Double(NSEC_PER_SEC)
        let time  = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            
            if self.videoPlayer.rate == 0.0{
                self.videoPlayer.seekToTime(CMTimeMakeWithSeconds(Float64(self.movieStartPositionArray[self.currentPlayingIndex]), Int32(NSEC_PER_SEC)))
            }
            
        })
        
         //player.play()
    }
    
    func touchUpInside(sender : UIButton){
        touchEventEnded()
    }
    
    func touchUpOutside(sender : UIButton){
          touchEventEnded()
    }
    
    func touchCancel(sender : UIButton){
            touchEventEnded()
    }
    
    func panGesture(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)

        if (!self.isLocked && -200 > translation.y) {
            println("swipe up!!!!!!!!!!")
            self.isLocked = true
            //lockedLabel.hidden = false
        }
        
    }
    
    
    
    func showVideoAnim(){
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.5)
        self.aVPlayerLayer.frame = self.originalVideoFrame
        CATransaction.commit()
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.videoView1.alpha = 1.0
            self.blackView.alpha = 0.7
            
        })
    }
    
    func closeVideoAnim(){
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.5)
        aVPlayerLayer.frame = CGRectMake(aVPlayerLayer.frame.origin.x, aVPlayerLayer.frame.origin.y, 0, 0)
        aVPlayerLayer.position = originalVideoPoint
        CATransaction.commit()
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.videoView1.alpha = 0
            self.blackView.alpha = 0
            
        })
    }
}