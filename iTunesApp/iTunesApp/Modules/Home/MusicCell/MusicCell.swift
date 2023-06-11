//
//  MusicTableViewCell.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import UIKit
import iTunesAPI
import AVFoundation

class MusicCell: UITableViewCell {
    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var musicLabel: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var collectionLabel: UILabel!
    @IBOutlet weak var playAndStopButton: UIButton!
    
    var player: AVPlayer?

    override func awakeFromNib() {
        super.awakeFromNib()
        playAndStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    
    func setCellWithValuesOf(_ music: Music) {
           updateUI(title: music.trackName,
                    artist: music.artistName,
                    collection: music.collectionName,
                    imageUrl: music.artworkUrl)
           if let url = URL(string: music.previewUrl) {
               player = AVPlayer(url: url)
           }
       }
       
       private func updateUI(title: String,
                             artist: String,
                             collection: String,
                             imageUrl: String) {
           self.musicLabel.text = title
           self.artistName.text = artist
           self.collectionLabel.text = collection
           
           
           let url = URL(string: imageUrl)
           DispatchQueue.global().async { [weak self] in
               if let data = try? Data(contentsOf: url!) {
                   if let image = UIImage(data: data) {
                       DispatchQueue.main.async {
                           self?.artistImage.image = image
                       }
                   }
               }
           }
       }

       override func prepareForReuse() {
           super.prepareForReuse()
           player?.pause()
           player = nil
           playAndStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal) // varsayılan olarak oynatma ikonu
       }
   }


