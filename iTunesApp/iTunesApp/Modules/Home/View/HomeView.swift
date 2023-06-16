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
    //MARK: - UI Elements
    @IBOutlet  weak var searchBar: UISearchBar!
    @IBOutlet  weak var tableView: UITableView!
    var welcomeLabel: UILabel!
    //MARK: - Variables
    var presenter: HomePresenterProtocol?
    var musicArray: Array<Music> = []
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setAccessibilityIdentifier()
        setupWelcomeLabel()
        presenter?.setSetupTableviewAndSearchBar()
        tableView.register(UINib(nibName: "MusicCell", bundle: nil),
                           forCellReuseIdentifier: "MusicCell")
        presenter?.setScreenTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        MusicPlayerService.shared.stop()
    }
    //MARK: - Functions
    private func setupWelcomeLabel() {
        welcomeLabel = UILabel()
        welcomeLabel.text = "Hoşgeldiniz, lütfen bir sanatçı aratın."
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 0
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(welcomeLabel)
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    
    
    func setAccessibilityIdentifier() {
        
        searchBar.searchTextField.accessibilityIdentifier = "homeSearchBar"
        tableView.accessibilityIdentifier = "homeTableView"
        
    }
    
}
//MARK: - SearchBar Extension
extension HomeView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchTerm = searchBar.text {
            showLoading()
            presenter?.startFetchingMusic(searchTerm: searchTerm)
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchBar.resignFirstResponder()
            musicArray = []
            tableView.reloadData()
            welcomeLabel.text = "Yeni bir şarkı dinlemek istiyorsanız. Lütfen bir sanatçı aratınız."
            welcomeLabel.isHidden = false
        }
    }
    
}
//MARK: - TableView Extensions
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
//MARK: - HomeViewProtocol Extensions
extension HomeView: HomeViewProtocol {
    
    func showMusic(musicArray: Array<Music>) {
        hideLoading()
        self.musicArray = musicArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.musicArray.isEmpty {
                self.welcomeLabel.text = "Lütfen doğru bir sanatçı ismi giriniz"
                self.welcomeLabel.isHidden = false
            } else {
                self.welcomeLabel.isHidden = true
            }
        }
    }
    
    func showError() {
        hideLoading()
        showAlert("Hata", "Veriler çekilirken hata oluştu")
        welcomeLabel.isHidden = false
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

