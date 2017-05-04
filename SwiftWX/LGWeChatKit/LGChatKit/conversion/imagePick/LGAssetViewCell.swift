//
//  LGAssetViewCell.swift
//  LGWeChatKit
//
//  Created by jamy on 10/28/15.
//  Copyright © 2015 jamy. All rights reserved.
//

import UIKit
import PhotosUI

class LGAssetViewCell: UICollectionViewCell {
    
    var viewModel: LGAssetViewModel? {
        didSet {
            viewModel?.image.observe {
                [unowned self] in
                if self.imageView.isHidden {
                    self.imageView.isHidden = false
                    self.livePhotoView.isHidden = true
                }
                self.imageView.image = $0
            }
            
            viewModel?.livePhoto.observe {
                [unowned self] in
                if $0.size.height != 0 {
                    self.imageView.isHidden = true
                    self.livePhotoView.isHidden = false
                    self.livePhotoView.livePhoto = $0
                }
            }
            
            viewModel?.asset.observe {
                [unowned self] in
                if $0.mediaType == .video {
                    self.playIndicator?.isHidden = false
                } else {
                    self.playIndicator?.isHidden = true
                }
            }
        }
    }
    
    var imageView: UIImageView!
    var livePhotoView: PHLivePhotoView!
    var playLayer: AVPlayerLayer?
    var playIndicator: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        
        playIndicator = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        playIndicator?.center = contentView.center
        playIndicator?.image = UIImage(named: "MessageVideoPlay")
        contentView.addSubview(playIndicator!)
        playIndicator?.isHidden = true
        
        livePhotoView = PHLivePhotoView()
        livePhotoView.isHidden = true
        contentView.addSubview(livePhotoView)
        
        livePhotoView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0))
        
        contentView.addConstraint(NSLayoutConstraint(item: livePhotoView, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .top, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: livePhotoView, attribute: .left, relatedBy: .equal, toItem: contentView, attribute: .left, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: livePhotoView, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: livePhotoView, attribute: .right, relatedBy: .equal, toItem: contentView, attribute: .right, multiplier: 1, constant: 0))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopPlayer()
    }
    
    func stopPlayer() {
        if let player = self.playLayer {
            player.player?.pause()
            player.removeFromSuperlayer()
        }
        playLayer = nil
    }
    
    func playLivePhoto() {
        if livePhotoView.livePhoto != nil {
            livePhotoView.startPlayback(with: .full)
        } else if playLayer != nil {
            playLayer?.player?.play()
        } else {
            PHImageManager.default().requestAVAsset(forVideo: (viewModel?.asset.value)!, options: nil, resultHandler: { (asset, audioMix, _:[AnyHashable: Any]?) -> Void in
                DispatchQueue.main.async(execute: { () -> Void in
                    if self.playLayer == nil {
                        let viewLayer = self.layer
                        let playItem = AVPlayerItem(asset: asset!)
                        playItem.audioMix = audioMix
                        let player = AVPlayer(playerItem: playItem)
                        let avPlayerLayer = AVPlayerLayer(player: player)
                        avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect
                        avPlayerLayer.frame = CGRect(x: 0, y: 0, width: viewLayer.bounds.width, height: viewLayer.bounds.height)
                        viewLayer.addSublayer(avPlayerLayer)
                        self.playLayer = avPlayerLayer
                        self.playLayer?.player?.play()
                    }
                })
            })
        }
    }
    
}
