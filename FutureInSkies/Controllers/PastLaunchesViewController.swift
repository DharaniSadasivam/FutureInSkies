//
//  ViewController.swift
//  FutureInSkies
//
//  Created by mac on 20/09/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit
import ObjectMapper
import SDWebImage

class PastLaunchesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    //MARK:- Initialization
    var tableView = UITableView()
    var launches = [RocketLaunch]()
    
    //MARK:- Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = "PAST LAUNCHES"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.03529411765, green: 0.6392156863, blue: 0.6666666667, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LaunchesListTableViewCell")
        view.addSubview(tableView)        
        getLaunches()
    }
    
    //MARK:- UITableViewDelegate & UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = LaunchesListTableViewCell(style: .default, reuseIdentifier: "LaunchesListTableViewCell")
        cell.missionNameLbl.text = launches[indexPath.row].missionName
        cell.launchDate.text = Utils.convertToFormattedDate(dateString: launches[indexPath.row].launchDateUTC)
        cell.spaceImgView.sd_setImage(with: URL(string: launches[indexPath.row].links.missionPatch), placeholderImage: #imageLiteral(resourceName: "launchPlaceHolder"))
        cell.lauchSite.text = launches[indexPath.row].lauchSiteName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vC = LaunchDetailViewController()
        vC.launch = launches[indexPath.row]
        navigationController?.pushViewController(vC, animated: true)
    }
    
    
    //MARK:- API Call
    func getLaunches() {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let urlString = "https://api.spacexdata.com/v2/launches"
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
                                    print("launchObject")
                                    self.launches = launchObject
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

