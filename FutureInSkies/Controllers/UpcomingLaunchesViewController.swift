//
//  UpcomingViewController.swift
//  FutureInSkies
//
//  Created by mac on 22/09/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class UpcomingLaunchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView = UITableView()
    var upcomingLanuches = [RocketLaunch]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.topItem?.title = "UPCOMING LAUNCHES"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.03529411765, green: 0.6392156863, blue: 0.6666666667, alpha: 1)
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LaunchesListTableViewCell")
        view.addSubview(tableView)
        getUpcomingLaunches()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK:- UITableViewDelegate & UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.upcomingLanuches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LaunchesListTableViewCell(style: .default, reuseIdentifier: "LaunchesListTableViewCell")
        cell.missionNameLbl.text = upcomingLanuches[indexPath.row].missionName
        cell.launchDate.text = Utils.convertToFormattedDate(dateString: upcomingLanuches[indexPath.row].launchDateUTC)
        cell.spaceImgView.sd_setImage(with: URL(string: upcomingLanuches[indexPath.row].links.missionPatch), placeholderImage: #imageLiteral(resourceName: "launchPlaceHolder"))
        cell.lauchSite.text = upcomingLanuches[indexPath.row].lauchSiteName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func getUpcomingLaunches() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let urlString = "https://api.spacexdata.com/v2/launches/upcoming"
        if let url = URL(string: urlString) {
            Utils.showHUD(view: self.view)
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                DispatchQueue.main.async {
                    Utils.hideHUD(view: self.view)
                    if error != nil {
                        print(error!.localizedDescription)
                    } else {
                        do {
                            if let json : [NSDictionary] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [NSDictionary] {
                                if let launchObject = Mapper<RocketLaunch>().mapArray(JSONObject: json as! [[String : AnyObject]]) {
                                    self.upcomingLanuches = launchObject
                                    self.tableView.reloadData()
                                } else {
                                    print("Error in json serialization1")
                                }
                            }
                        } catch {
                            print("Error in json serialization")
                        }
                    }
                }
            })
            task.resume()
        }
        
    }
}
