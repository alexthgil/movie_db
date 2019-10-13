//
//  TileDetailsViewController.swift
//  Cinema
//
//  Created by Alex on 9/3/19.
//  Copyright © 2019 Alex. All rights reserved.
//

import UIKit
import WebKit

class TileDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var backgroundPosterImageView: UIImageView?
    @IBOutlet weak var posterImageView: UIImageView?
    @IBOutlet weak var voteAverageLabel: UILabel?
    @IBOutlet weak var voteCountLabel: UILabel?
    @IBOutlet weak var idLabel: UILabel?
    @IBOutlet weak var mediaTypeLabel: UILabel?
    @IBOutlet weak var popularityLabel: UILabel?
    @IBOutlet weak var originalLanguageLabel: UILabel?
    @IBOutlet weak var releaseDateLabel: UILabel?
    @IBOutlet weak var overviewLabel: UILabel?
    
    @IBOutlet weak var contentStackView: UIStackView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillTileData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        posterImageView?.image = nil
    }
    
    var tile: PlainTile?
    var relatedTrailer = [WebViewViewController]()
    
    func show(_ data: PlainTile) {
        self.tile = data
        
        fillTileData()
        
        if let id = tile?.id {
            let dataBase = DatabaseIO.shared
            let urlComponents = dataBase.buildUrlComponentsForRelatedVideos(for:  id)
            
            let task = dataBase.executableRequest(with: VideosResponse.self, urlComponents: urlComponents) { (videosResponse) in
                DispatchQueue.main.async {
                    
                    for video in videosResponse.results {
                        let key = video.key
                        if key != "" && video.site == "YouTube" {
                            let v = WebViewViewController()
                            _ = v.view
                            v.show(key)
                            self.relatedTrailer.append(v)
                            self.contentStackView?.addArrangedSubview(v.view)
                        }
                    }
                }
            }
            task?.resume()
        }
    }
    
    weak var parentView: UIView?
        
    func setParentView(_ view: UIView) {
        parentView = view
        
        guard let parentView = parentView, let posterImageView = posterImageView else {
            return
        }
        
        
        
        let eqHeightConstraint = NSLayoutConstraint(item: posterImageView,
                                                attribute: .height,
                                                relatedBy: .lessThanOrEqual,
                                                 toItem: parentView,
                                                 attribute: .height,
                                                 multiplier: 0.8,
                                                 constant: 1.0)
       
        eqHeightConstraint.isActive = true
    }

    func fillTileData() {
        
        let effect = UIBlurEffect(style: .regular)
        let effectView = UIVisualEffectView(effect: effect)
        
        // set boundry and alpha
        effectView.frame = self.view.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        effectView.alpha = 1.0
        
        backgroundPosterImageView?.addSubview(effectView)
        
        titleLabel?.text = tile?.title ?? ""
        let t = tile?.overview ?? ""
        overviewLabel?.text = t // + t + t + t + t + t + t + t
        overviewLabel?.numberOfLines = 0
        voteAverageLabel?.text = "\(tile?.voteAverage ?? 0.0)"
        voteCountLabel?.text = "\(tile?.voteCount ?? 0)"
        idLabel?.text = "\(tile?.id ?? 0)"
        mediaTypeLabel?.text = "movie"
        popularityLabel?.text = "\(tile?.popularity ?? 0.0)"
        releaseDateLabel?.text = "\(tile?.releaseDate ?? "")"
        
        self.tile?.loadPosterWithSize(.large, completionHandler: { [weak self] (img) in
            DispatchQueue.main.async {
                self?.posterImageView?.image = img
                self?.backgroundPosterImageView?.image = img
            }
        })
        
    }
    
    func onTileDidLoadPoster(tile: Tile, posterImageData: Data?) {
        if self.tile === tile {
            DispatchQueue.main.async {
                if let posterImageData = posterImageData {
                    let image = UIImage.init(data: posterImageData)
                    self.posterImageView?.image = image
                }
            }
        }
    }

}
