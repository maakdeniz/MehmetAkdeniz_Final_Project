//
//  MusicCell.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import UIKit
import iTunesAPI

final class MusicCell: UITableViewCell {
    
    @IBOutlet private weak var artistImage: UIImageView!
    @IBOutlet private weak var musicLabel: UILabel!
    @IBOutlet private weak var artistName: UILabel!
    @IBOutlet private weak var collectionLabel: UILabel!
    @IBOutlet private weak var playAndStopButton: UIButton!
    
    var musicUrl: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAccessibilityIdentifier()
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayButtonImage), name: .playbackChanged, object: nil)
        playAndStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func playAndStopAction(_ sender: Any) {
        guard let musicUrl = musicUrl else { return }
        
        if MusicPlayerService.shared.isPlaying(url: musicUrl) {
            MusicPlayerService.shared.pause()
            stopPlaying()
        } else {
            MusicPlayerService.shared.currentCell?.stopPlaying()
            MusicPlayerService.shared.currentCell = self
            MusicPlayerService.shared.play(url: musicUrl)
            startPlaying()
        }
    }
    
    func setAccessibilityIdentifier() {
        artistImage.accessibilityIdentifier = "cellArtistImage"
        musicLabel.accessibilityIdentifier = "cellMusicLabel"
        artistName.accessibilityIdentifier = "cellArtistName"
        collectionLabel.accessibilityIdentifier = "cellCollectionLabel"
        playAndStopButton.accessibilityIdentifier = "MusicCellPlayButton"
        self.accessibilityIdentifier = "MusicCell0"
    }
    
    func startPlaying() {
        playAndStopButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
    }
    
    func stopPlaying() {
        playAndStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    func setCellWithValuesOf(_ music: Music) {
        updateUI(title: music.trackName ?? "",
                 artist: music.artistName ?? "",
                 collection: music.collectionName ?? "",
                 imageUrl: music.artworkUrl ?? "")
        if let url = URL(string: music.previewUrl ?? "") {
            musicUrl = url
        }
        
        setAccessibilityIdentifier()
    }
    
    @objc private func updatePlayButtonImage() {
        if musicUrl == MusicPlayerService.shared.currentURL {
            playAndStopButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        } else {
            playAndStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
    deinit {
            NotificationCenter.default.removeObserver(self)
        }
    
    private func updateUI(title: String,
                          artist: String,
                          collection: String,
                          imageUrl: String) {
        self.musicLabel.text = title
        self.artistName.text = artist
        self.collectionLabel.text = collection
        
        guard let url = URL(string: imageUrl) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
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
        if musicUrl == MusicPlayerService.shared.currentURL {
            MusicPlayerService.shared.stop()
            stopPlaying()
        } else {
            stopPlaying()
        }
    }
}
