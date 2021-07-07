//
//  TabBarController.swift
//  TeamWorkMap
//
//  Created by AltaSoftware MacMINI on 7/8/21.
//

import UIKit

class TabBarController: UITabBarController, Storyboarded, CoordinatorDelegate {
    
    var coordinator: CoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = self.viewControllers![0] as! SelectedViewController
        vc1.coordinator = coordinator


        
        let vc2 = self.viewControllers![1] as! UserLocationViewController
        vc2.coordinator = coordinator
    }

}
