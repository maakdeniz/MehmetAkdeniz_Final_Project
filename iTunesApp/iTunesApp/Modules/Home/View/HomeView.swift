import UIKit
import iTunesAPI


protocol PresenterToViewHomeProtocol {
    func showMusic(musicArray:Array<Music>)
    func showError()
    
}

class HomeView: UIViewController, PresenterToViewHomeProtocol, LoadingShowable, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: ViewToPresenterHomeProtocol?
    var musicArray: Array<Music> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
    }
    
    func showMusic(musicArray: Array<Music>) {
        hideLoading()
        self.musicArray = musicArray
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showError() {
        hideLoading()
        // Hata durumunda kullanıcıya bir uyarı mesajı gösterilebilir.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
        cell.setCellWithValuesOf(musicArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            presenter?.showDetailScreen(music: musicArray[indexPath.row])
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchTerm = searchBar.text {
            showLoading()
            presenter?.startFetchingMusic(searchTerm: searchTerm)
        }
    }
}
