//
//  SecondViewController.swift
//  iTunesClassApp
//
//  Created by Israrul on 4/8/20.
//  Copyright © 2020 Israrul Haque. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    var favAlbumArray = [Artist]()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favourite Song"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "FavAlbumCell", bundle: nil), forCellReuseIdentifier: "FavAlbumCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabBar = tabBarController as! BaseTabBarViewController
        favAlbumArray = tabBar.favAlbum ?? []
        tableView.reloadData()
    }
    
 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favAlbumArray.isEmpty {
            return 0
        } else {
            return favAlbumArray.count
        }
    }
       
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavAlbumCell", for: indexPath) as! FavAlbumCell
        cell.albumTitleLabel.text = favAlbumArray[indexPath.row].trackName
        cell.genreLabel.text = favAlbumArray[indexPath.row].primaryGenreName
        let url = URL(string: favAlbumArray[indexPath.row].artworkUrl100!)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: favAlbumArray[indexPath.row].previewUrl!)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}

