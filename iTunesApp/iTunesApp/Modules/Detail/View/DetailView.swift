//
//  DetailView.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 7.06.2023.
//

import UIKit
import iTunesAPI

protocol DetailViewProtocol {
    var music: Music? { get set }
    func showError()
    func showMusicDetail()
    func showAddedToFavorites()
    func showRemovedFromFavorites()
    func updateFavoriteStatus(isFavorite: Bool, withAnimation: Bool)
    func updatePlayButton(isPlaying: Bool)
    func presentAddConfirmation()
    func presentRemoveConfirmation()
}

final class DetailView: BaseView, DetailViewProtocol {

    var presenter: DetailPresenterProtocol?
    
    @IBOutlet private weak var artisImage: UIImageView!
    @IBOutlet private weak var artistNameLabel: UILabel!
    @IBOutlet private weak var collectionLabel: UILabel!
    @IBOutlet private weak var playAndStopButton: UIButton!
    @IBOutlet private weak var musicNameLabel: UILabel!
    @IBOutlet private weak var musicGenreLabel: UILabel!
    @IBOutlet private weak var musicPriceLabel: UILabel!
    @IBOutlet private weak var collectionPriceLabel: UILabel!
    
    var music: Music?
    var musicUrl: URL?
    lazy var favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playAndStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        presenter?.startSetup()
        
        self.navigationItem.rightBarButtonItem = favoriteButton
        presenter?.checkIfFavoriteOnInit(for: music!)
        setAccessibilityIdentifier()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MusicPlayerService.shared.stop()
        playAndStopButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    @objc private func favoriteButtonTapped() {
        presenter?.handleFavoriteTap(for: music!)
    }
    
    @IBAction func playAndStopAction(_ sender: Any) {
        presenter?.playOrStopMusic(for: music!)
    }
    
    func setAccessibilityIdentifier() {
        artisImage.accessibilityIdentifier = "detailArtistImage"
        artistNameLabel.accessibilityIdentifier = "detailArtistNameLabel"
        collectionLabel.accessibilityIdentifier = "detailCollectionLabel"
        playAndStopButton.accessibilityIdentifier = "detailPlayAndStopButton"
        musicNameLabel.accessibilityIdentifier = "detailMusicNameLabel"
        musicGenreLabel.accessibilityIdentifier = "detailMusicGenreLabel"
        musicPriceLabel.accessibilityIdentifier = "detailMusicPriceLabel"
        collectionPriceLabel.accessibilityIdentifier = "detailCollectionPriceLabel"
        favoriteButton.accessibilityIdentifier = "detailFavoriteButton"
    }
    
    func showMusicDetail() {
        if let music = music {
            artistNameLabel?.text = music.artistName
            collectionLabel?.text = music.collectionName
            musicNameLabel?.text = music.trackName
            musicGenreLabel?.text = music.primaryGenreName
            musicPriceLabel?.text = "Track Price: " +
            String(format: "%.2f", music.trackPrice ?? 0.0) +
            " TRY"
            collectionPriceLabel?.text = "Collection Price: " +
            String(format: "%.2f", music.collectionPrice ?? 0.0) +
            " TRY"
            
            if let url = URL(string: music.artworkUrl ?? "") {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async {
                            self.artisImage?.image = UIImage(data: data)
                        }
                    }
                }
            }
        }
    }

    func showError() {
        showAlert("Hata", "Veriler listelenirken hata oluştu.")
    }
    
    func showAddedToFavorites() {
        self.favoriteButton.tintColor = UIColor.systemBlue
        self.favoriteButton.image = UIImage(systemName: "trash")
    }

    func showRemovedFromFavorites() {
        self.favoriteButton.tintColor = UIColor.systemBlue
        self.favoriteButton.image = UIImage(systemName: "heart")
        
    }
    
    func presentConfirmation(
        title: String,
        message: String,
        confirmTitle: String,
        confirmAction: @escaping () -> Void
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: { _ in
            confirmAction()
        }))
        alert.addAction(UIAlertAction(title: "Hayır", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    func presentAddConfirmation() {
        presentConfirmation(
            title: "Favorilere Ekle",
            message: "Bu şarkıyı favorilere eklemek istediğinize emin misiniz?",
            confirmTitle: "Evet"
        ) {
            self.presenter?.confirmAddToFavorites(for: self.music!)
        }
    }

    func presentRemoveConfirmation() {
        presentConfirmation(
            title: "Favorilerden Çıkar",
            message: "Bu şarkıyı favorilerinizden çıkarmak istediğinize emin misiniz?",
            confirmTitle: "Evet"
        ) {
            self.presenter?.confirmRemoveFromFavorites(for: self.music!)
        }
    }
    
    func updateFavoriteStatus(isFavorite: Bool, withAnimation: Bool) {
        self.favoriteButton.image = isFavorite ? UIImage(systemName: "trash") : UIImage(systemName: "heart")
        if withAnimation {
            UIView.animate(withDuration: 0.5) {
                self.favoriteButton.tintColor = isFavorite ? UIColor.systemBlue : UIColor.systemBlue
            }
        } else {
            self.favoriteButton.tintColor = isFavorite ? UIColor.systemBlue : UIColor.systemBlue
        }
    }
    
    func updatePlayButton(isPlaying: Bool) {
        let buttonImage = UIImage(systemName: isPlaying ? "pause.fill" : "play.fill")
        playAndStopButton.setImage(buttonImage, for: .normal)
    }
}
