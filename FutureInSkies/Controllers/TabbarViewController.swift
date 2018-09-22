//
//  TabbarViewController.swift
//  FutureInSkies
//
//  Created by mac on 22/09/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UITabBarItem.appearance()
        let attributes = [NSAttributedStringKey.font: UIFont.rocketFont(fontSize: 20.0, weight: .Bold)]
        
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        let selectedColorAttribute = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.03529411765, green: 0.6392156863, blue: 0.6666666667, alpha: 1)]
        appearance.setTitleTextAttributes(selectedColorAttribute, for: .selected)
        
        let unselectedColorAttribute = [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)]
        appearance.setTitleTextAttributes(unselectedColorAttribute, for: .normal)
        
        let firstVC = UINavigationController(rootViewController: PastLaunchesViewController())
        firstVC.tabBarItem.title = "Past"
        
        firstVC.tabBarItem.image = #imageLiteral(resourceName: "pastLaunch").withRenderingMode(.alwaysOriginal)
        firstVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let secondVC = UINavigationController(rootViewController: UpcomingLaunchesViewController())
        secondVC.tabBarItem.title = "Upcoming"
        secondVC.tabBarItem.image = #imageLiteral(resourceName: "upcomingLaunch").withRenderingMode(.alwaysOriginal)
        secondVC.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
        self.viewControllers = [firstVC, secondVC]
    }    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
