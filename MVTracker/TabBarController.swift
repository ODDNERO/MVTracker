//
//  TabBarController.swift
//  MVTracker
//
//  Created by NERO on 8/10/24.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        searchVC.tabBarItem = UITabBarItem(title: "",
                                           image: UIImage(systemName: "waveform.badge.magnifyingglass"),
                                           selectedImage: UIImage(systemName: "waveform.badge.magnifyingglass"))
        
        let myTracksVC = UINavigationController(rootViewController: MyTracksViewController())
        myTracksVC.tabBarItem = UITabBarItem(title: "",
                                             image: UIImage(systemName: "opticaldisc"),
                                             selectedImage: UIImage(systemName: "music.note.list"))
        
        setViewControllers([searchVC, myTracksVC], animated: true)
        tabBar.tintColor = .systemPink
        selectedIndex = 0
    }
}
