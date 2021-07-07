//
//  File.swift
//  SecondTeamWork
//
//  Created by user200328 on 7/6/21.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    
    
    // MARK: - Variables
    private var window: UIWindow?
    private var navigationController: UINavigationController?
    
    // MARK: - Initialisation
    init(_ window: UIWindow?, navigationController: UINavigationController?) {
        self.window = window
        self.navigationController = navigationController
        
    }
    
    func start() {
        let vc = TabBarController.instantiateFromStoryboard()
        vc.coordinator = self
        navigationController?.pushViewController(vc, animated: true)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

//    func proceedToImageEditVC(image: UIImage) {
//        let vc = EditImageViewController.instantiateFromStoryboard()
//        vc.coordinator = self
//        vc.newImage = image
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    func proceedToImageEditVC(image: UIImage) {
//        let vc = EditImageViewController.instantiateFromStoryboard()
//        vc.coordinator = self
//        vc.newImage = image
//        navigationController?.pushViewController(vc, animated: true)
//    }
//    func proceedToImageEditVC(image: UIImage) {
//        let vc = EditImageViewController.instantiateFromStoryboard()
//        vc.coordinator = self
//        vc.newImage = image
//        navigationController?.pushViewController(vc, animated: true)
//    }
}
