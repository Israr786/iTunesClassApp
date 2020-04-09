//
//  FirstViewController.swift
//  iTunesClassApp
//
//  Created by Israrul on 4/8/20.
//  Copyright © 2020 Israrul Haque. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {
    
    var artish = [Artist]()
    var favAlbum = [Artist]()
    var dict = [String: [Artist]]()
    var groupArtistArray = [[Artist]]()
    let imageCache = WrappedCache<AnyObject, AnyObject>()
    var imageDownloadInProgress:[IndexPath] = []
    var searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "search artist or songs"
        searchController.searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "AlbumCell", bundle: nil), forCellReuseIdentifier: "AlbumCell")
    }
    
    func fetchData(searchTerm: String) {
        
        ContentService().fetchUsers(withTerm: searchTerm) { [weak self] (result)  in
            guard let strongSelf = self else { return }
            guard case .success(let data) = result else { return }
            guard let results = data?.results else { return }
            strongSelf.artish = results
            DispatchQueue.main.async { [weak self] in
                let albums = self?.createGroupedAlbums(albums: self!.artish) ?? []
                self?.groupArtistArray = albums
                self?.tableView.reloadData()
            }
        }
       
    }
            
    func createGroupedAlbums(albums: [Artist]) -> [[Artist]] {
        let groupedDict = Dictionary(grouping: albums) { (album)  in
            return album.kind ?? ""
        }
        dict = groupedDict
        var groupedAlbum = [[Artist]]()
        let keys = groupedDict.keys.sorted { $0 > $1 }
            keys.forEach { (key) in
                groupedAlbum.append(groupedDict[key]!)
            }
            return groupedAlbum
    }
}


extension FirstViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupArtistArray.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let titleArray = dict.keys.sorted {$0 > $1}
        return titleArray[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArtistArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        let album = groupArtistArray[indexPath.section][indexPath.row]
        
        cell.albumTitleLabel.text = album.trackName
        cell.genreLabel.text = album.primaryGenreName
        let url = URL(string: album.artworkUrl100!)
        cell.artworkView.image = UIImage()//or keep any placeholder here
        cell.tag = indexPath.row
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                if cell.tag == indexPath.row{
                    cell.artworkView.image = UIImage(data: data)
                }
            }
        }
        task.resume()
        cell.delegate = self
        cell.album = artish[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = groupArtistArray[indexPath.section][indexPath.row]
        let url = URL(string: album.previewUrl!)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    func refreshTablView(for indexPath:IndexPath) {
        tableView?.reloadRows(at:[indexPath], with: UITableView.RowAnimation.automatic)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchData(searchTerm: searchBar.text!)
    }
    
func getImage(url:String, indexPath:IndexPath) -> Data? {

        //Checking Cached Image
        if let image = imageCache[url as AnyObject] {
            return image as? Data
        }else {

            //Download Inprogress
            if imageDownloadInProgress.contains(indexPath) {
                return nil
            } else {
                //Downloading image if not cached
                self.imageDownloadInProgress.append(indexPath)
                let url = URL(string: artish[indexPath.row].artworkUrl100!)
                URLSession.shared.dataTask(with: url!) { data , response, error in
                 //   print(error, response, data)
                    if let index = self.imageDownloadInProgress.firstIndex(of:indexPath) {
                        self.imageDownloadInProgress.remove(at: index)
                    }
                    self.imageCache[url as AnyObject] = data as AnyObject
                        DispatchQueue.main.async {
                            self.refreshTablView(for: indexPath)
                        }
                }.resume()
            }
        }
        return nil
    }
}

extension FirstViewController: CellDelegate {
    func tapButton(fav: Artist) {
        favAlbum.append(fav)
        print(favAlbum.count)
        let tabBar = tabBarController as! BaseTabBarViewController
        tabBar.favAlbum = favAlbum
    }
}


