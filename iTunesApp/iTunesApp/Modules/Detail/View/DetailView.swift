//
//  DetailView.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 7.06.2023.
//

import UIKit
import iTunesAPI
import AVFoundation

protocol PresenterToViewDetailProtocol {
    func showMusicDetail()
    func showError()
}

class DetailView: UIViewController, PresenterToViewDetailProtocol {
    
    var presenter: ViewToPresenterDetailProtocol?
    
    @IBOutlet weak var artisImage: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var playAndStopButton: UIButton!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var musicGenreLabel: UILabel!
    @IBOutlet weak var musicPriceLabel: UILabel!
    @IBOutlet weak var collectionPriceLabel: UILabel!
    
    var music: Music? {
            didSet {
                showMusicDetail()
            }
        }
    var player: AVPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailView loaded")
        playAndStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        presenter?.startSetup()
        
    }
    
    @IBAction func playAndStopAction(_ sender: Any) {
        if player?.rate == 0 {
                   player?.play()
            playAndStopButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
               } else {
                   player?.pause()
                   playAndStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal) // oynatma ikonu
               }
    }
    
    func showMusicDetail() {
        if let music = music {
            artistNameLabel?.text = music.artistName
            collectionLabel?.text = music.collectionName
            musicNameLabel?.text = music.trackName
            
            if let url = URL(string: music.artworkUrl) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.artisImage?.image = UIImage(data: data)
                        }
                    }
                }
            }
            if let url = URL(string: music.previewUrl) {
                player = AVPlayer(url: url)
            }
        } else {
            print("Music data is nil")
        }
    }

    func showError() {
        let alert = UIAlertController(title: "Error", message: "An error occurred while loading the music details.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
    }

}
