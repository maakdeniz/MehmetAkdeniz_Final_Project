//
//  HomeView.swift
//  iTunesApp
//
//  Created by Mehmet Akdeniz on 6.06.2023.
//

import UIKit
import iTunesAPI

protocol HomeViewProtocol {
    func showMusic(musicArray:Array<Music>)
    func showError()
    func setTitle(_ title: String)
    func setupTableviewAndSearchBar()
}

final class HomeView: BaseView, LoadingShowable{
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    var presenter: HomePresenterProtocol?
    var musicArray: Array<Music> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityIdentifier()
        
        presenter?.setSetupTableviewAndSearchBar()
        tableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        presenter?.setScreenTitle()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        MusicPlayerService.shared.stop()
    }
    
    func setAccessibilityIdentifier() {
        searchBar.accessibilityIdentifier = "homeSearchBar"
        tableView.accessibilityIdentifier = "homeTableView"
    }
    
}

extension HomeView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchTerm = searchBar.text {
            showLoading()
            presenter?.startFetchingMusic(searchTerm: searchTerm)
        }
    }
}

extension HomeView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
        cell.setCellWithValuesOf(musicArray[indexPath.row])
        cell.accessibilityIdentifier = "MusicCell\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showDetailScreen(music: musicArray[indexPath.row])
    }
    
}

extension HomeView: HomeViewProtocol {
    
    func showMusic(musicArray: Array<Music>) {
        hideLoading()
        self.musicArray = musicArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        hideLoading()
        showAlert("Hata", "Veriler çekilirken hata oluştu")
    }
    
    func setTitle(_ title: String) {
        self.navigationItem.title = title
    }
    
    func setupTableviewAndSearchBar() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

