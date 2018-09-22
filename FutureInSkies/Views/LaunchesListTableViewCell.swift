//
//  LaunchesListTableViewCell.swift
//  FutureInSkies
//
//  Created by mac on 20/09/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class LaunchesListTableViewCell: UITableViewCell {
    var mainStackView = UIStackView()
    var spaceImgView = UIImageView()
    var labelStackView = UIStackView()
    var missionNameLbl = UILabel()
    var launchDate = UILabel()
    var lauchSite = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder)")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.autolayoutSubView()
    }

    private func autolayoutSubView() {
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 5).isActive = true
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillProportionally
        mainStackView.spacing = 20
        
        mainStackView.addArrangedSubview(spaceImgView)
        spaceImgView.translatesAutoresizingMaskIntoConstraints = false
        spaceImgView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        spaceImgView.contentMode = .scaleAspectFit
        
        spaceImgView.layer.masksToBounds = true
        spaceImgView.layer.cornerRadius = 5
        
        mainStackView.addArrangedSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillEqually
        labelStackView.alignment = .fill
        
        labelStackView.addArrangedSubview(missionNameLbl)
        missionNameLbl.font = UIFont.rocketFont(fontSize: 16, weight: .Bold)
        missionNameLbl.textColor = .black
        lauchSite.font = UIFont.rocketFont(fontSize: 14, weight: .Regular)
        lauchSite.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        launchDate.font = UIFont.rocketFont(fontSize: 12, weight: .Italic)
        lauchSite.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        labelStackView.addArrangedSubview(lauchSite)
        labelStackView.addArrangedSubview(launchDate)        
    }
}
