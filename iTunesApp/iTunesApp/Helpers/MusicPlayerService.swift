//
//  MusicPlayerService.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 8.06.2023.
//


import AVFoundation
import UIKit

class MusicPlayerService {
    
    static let shared = MusicPlayerService()
    
    var player: AVPlayer?
    var currentURL: URL?
    weak var currentCell: MusicCell?
    
    private init() {}
    
    func play(url: URL) {
        if currentURL != url {
            stop()
            player = AVPlayer(url: url)
            currentURL = url
            NotificationCenter.default.post(name: .playbackChanged, object: nil)
        }
        player?.play()
    }
    
    func pause() {
        player?.pause()
        NotificationCenter.default.post(name: .playbackChanged, object: nil)
    }
    
    func isPlaying(url: URL) -> Bool {
        return currentURL == url && player?.rate != 0
    }
    
    func stop() {
        player?.pause()
        player = nil
        currentURL = nil
        currentCell = nil
        NotificationCenter.default.post(name: .playbackChanged, object: nil)
    }
}

extension Notification.Name {
    static let playbackChanged = Notification.Name("playbackChanged")
}

