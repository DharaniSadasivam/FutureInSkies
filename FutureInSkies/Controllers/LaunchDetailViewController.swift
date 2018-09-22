//
//  LauchDetailViewController.swift
//  FutureInSkies
//
//  Created by mac on 22/09/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class LaunchDetailViewController: UIViewController {
    
    //MARK:- Initialization
    var launch: RocketLaunch?

    lazy var scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(scrollView)
        setViews()
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    //MARK:- Create views
    func setViews() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        let launchImgView = UIImageView(frame: CGRect(x: (view.frame.size.width / 2) - 10, y: 20, width: 50, height: 50))
        launchImgView.contentMode = .scaleAspectFill
        scrollView.addSubview(launchImgView)
        
        if let launch = launch {
            //Initial content
            launchImgView.sd_setImage(with: URL(string: launch.links.missionPatch), placeholderImage: #imageLiteral(resourceName: "launchPlaceHolder"))
            getTitleLabel(text: "\(launch.missionName)")
            getLabel(text: "Flight Number: \(launch.flightNumber)")
            getLabel(text: "Launch Site: \(launch.lauchSiteName)")
            getLabel(text: "Lauch Date: \(Utils.convertToFormattedDate(dateString: launch.launchDateUTC))")
            //Payload
            if launch.rocket.payloads.count > 0 {
                getTitleLabel(text: "Payload(s)")
                for (index, payload) in launch.rocket.payloads.enumerated() {
                    getLabel(text: payload.payloadId.isEmpty ? "" : "Payload Id: \(payload.payloadId)")
                    getLabel(text: payload.manufacturer.isEmpty ? "" : "Manufacturer: \(payload.manufacturer)")
                    getLabel(text: payload.payloadType.isEmpty ? "" : "Payload Type: \(payload.payloadType)")
                    getLabel(text: payload.payloadMassKg == 0 ? "" : "Payload Mass: \(payload.payloadMassKg)")
                    let customers = getCustomers(index: index)
                    getLabel(text: customers.isEmpty ? "" : "Customers: \(customers)")
                }
            }
            
            
            //Rocket
            if !launch.rocket.rocketName.isEmpty { getTitleLabel(text: "Rocket") }
            getLabel(text: "Rocket Name: \(launch.rocket.rocketName)")
            getLabel(text: "Rocket Version: \(launch.rocket.rocketType)")
            
            //Cores
            if launch.rocket.cores.count > 0 {
                getTitleLabel(text: "Core(s)")
                for core in launch.rocket.cores {
                    getLabel(text: core.coreSerial.isEmpty ? "" : "Core Serial: \(core.coreSerial)")
                    getLabel(text: "Core flight: \(core.flight)")
                    getLabel(text: core.landingType.isEmpty ? "" : "Landing Type: \(core.landingType)")
                    getLabel(text: core.landSuccess ? "Landing Success: Yes" : "Landing Success: No")
                    getLabel(text: core.landingVehicle.isEmpty ? "" : "Landing Vehicle: \(core.landingVehicle)")
                }
            }
            
            //Description
            if !launch.details.isEmpty { getTitleLabel(text: "Description") }
            getLabel(text: launch.details)
            
            //Links
            addLinks()
            
        }
        scrollView.contentSize.height = scrollView.subviews.last!.frame.size.height + scrollView.subviews.last!.frame.origin.y + 40
    }
    
    func getTitleLabel(text: String) {
        var lbl = UILabel()
        if let previousView = scrollView.subviews.last {
            lbl = UILabel(frame: CGRect(x: 10, y: previousView.frame.origin.y + previousView.frame.size.height + 20, width: self.view.frame.size.width - 10, height: 20))
        }
            lbl.text = text
            lbl.font = UIFont.rocketFont(fontSize: 18, weight: .Bold)
            lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            scrollView.addSubview(lbl)
    }
    
    func getLabel(text: String) {
        var lbl = UILabel()
        if !text.isEmpty {
            if let previousLbl = scrollView.subviews.last {
            lbl = UILabel(frame: CGRect(x: 10, y: previousLbl.frame.origin.y + previousLbl.frame.size.height, width: self.view.frame.size.width - 10, height: text.height(withConstrainedWidth: (self.view.frame.size.width - 10), font: UIFont.rocketFont(fontSize: 14, weight: .Regular))))
            }
            lbl.text = text
            lbl.font = UIFont.rocketFont(fontSize: 14, weight: .Regular)
            lbl.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            lbl.numberOfLines = 0
            scrollView.addSubview(lbl)
        }
    }
    
    func addLinks() {
        if let links = launch?.links {
            if let lastView = scrollView.subviews.last {
                if !links.videoLink.isEmpty {
                    let videoBtn = UIButton(frame: CGRect(x: lastView.frame.size.width / 2, y: lastView.frame.origin.y + lastView.frame.size.height + 20, width:  30, height: 30))
                    videoBtn.setImage(#imageLiteral(resourceName: "redditImg"), for: .normal)
                
                    videoBtn.addTarget(self, action: #selector(openUrl(_:)), for: .touchUpInside)
                    videoBtn.tag = 1
                    scrollView.addSubview(videoBtn)
                }
                
                if !links.wikipedia.isEmpty {
                    let wikiBtn = UIButton(frame: CGRect(x: (lastView.frame.size.width / 2 - 40), y: lastView.frame.origin.y + lastView.frame.size.height + 20, width:  30, height: 30))
                    wikiBtn.setImage(#imageLiteral(resourceName: "wikiLinkImg"), for: .normal)
                    wikiBtn.addTarget(self, action: #selector(openUrl(_:)), for: .touchUpInside)
                    wikiBtn.tag = 2
                    scrollView.addSubview(wikiBtn)
                }
            }
            
        }
        
    }
    
    @objc func openUrl(_ sender: UIButton) {
        let link = sender.tag == 2 ? launch!.links.wikipedia : launch!.links.videoLink
        Utils.openUrl(url: link)
    }
    
    func getCustomers(index: Int) -> String {
        var customers = ""
        if let launch = launch {
            let payloadCustomer = launch.rocket.payloads[index].customers
            for (indexVal, customer) in payloadCustomer.enumerated() {
                if indexVal == payloadCustomer.count - 1 {
                    customers.append(customer + ", ")
                } else {
                    customers.append(customer)
                }
            }
        }
     return customers
    }
    
}
