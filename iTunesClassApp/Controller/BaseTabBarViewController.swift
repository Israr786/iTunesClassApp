//
//  BaseTabBarViewController.swift
//  iTunesClassApp
//
//  Created by Israrul on 4/8/20.
//  Copyright © 2020 Israrul Haque. All rights reserved.
//

import UIKit

class BaseTabBarViewController: UITabBarController {

    var favAlbum: [Artist]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
