//
//  RocketLaunch.swift
//  FutureInSkies
//
//  Created by mac on 21/09/18.
//  Copyright © 2018 mac. All rights reserved.
//

import Foundation
import ObjectMapper

class RocketLaunch: NSObject, Mappable {
    var flightNumber = 0
    var missionName = ""
    var missionId = [String]()
    var launchYear = ""
    var launchDateUTC = ""
    var launchDateLocal = ""
    var isTentative = false
    var rocket = Rocket()
    var lauchSiteName = ""
    var links = Links()
    var details = ""
    
    required init?(map: Map) {
        super.init()
    }
    
    override init() {
        super.init()
    }
    func mapping(map: Map) {
        flightNumber <- map["flight_number"]
        missionName <- map["mission_name"]
        missionId <- map["mission_id"]
        launchYear <- map["launch_year"]
        launchDateUTC <- map["launch_date_utc"]
        launchDateLocal <- map["launch_date_local"]
        isTentative <- map["is_tentative"]
        rocket <- map["rocket"]
        lauchSiteName <- map["launch_site.site_name"]
        links <- map["links"]
        details <- map["details"]
    }
}


class Rocket: NSObject, Mappable {
    var rocketName = ""
    var rocketId = ""
    var rocketType = ""
    var cores = [Core]()
    var payloads = [Payload]()
    
    required init?(map: Map) {
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        rocketId <- map["rocket_id"]
        rocketName <- map["rocket_name"]
        rocketType <- map["rocket_type"]
        cores <- map["first_stage.cores"]
        payloads <- map["second_stage.payloads"]
    }
}


class Core: NSObject, Mappable {
    var coreSerial = ""
    var flight = 0
    var block = 0
    var reused = false
    var landSuccess = false
    var landingType = ""
    var landingVehicle = ""
    required init?(map: Map) {
       super.init()
    }
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        coreSerial <- map["core_serial"]
        flight <- map["flight"]
        block <- map["block"]
        reused <- map["reused"]
        landSuccess  <- map["land_success"]
        landingType <- map["landing_type"]
        landingVehicle <- map["landing_vehicle"]
    }
}

class Payload: NSObject, Mappable {
    var payloadId = ""
    var customers = [String]()
    var nationality = ""
    var manufacturer = ""
    var payloadType = ""
    var payloadMassKg = 0
    var orbit = ""
    var reused = false
    
    required init?(map: Map) {
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        payloadId <- map["payload_id"]
        customers <- map["customers"]
        nationality <- map["nationality"]
        manufacturer <- map["manufacturer"]
        payloadType <- map["payload_type"]
        payloadMassKg <- map["payload_mass_kg"]
        orbit <- map["orbit"]
        reused <- map["reused"]
        }
}

class Links: NSObject, Mappable {
    var videoLink = ""
    var wikipedia = ""
    var missionPatchSmall = ""
    var missionPatch = ""
    
    required init?(map: Map) {
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        videoLink <- map["video_link"]
        wikipedia <- map["wikipedia"]
        missionPatchSmall <- map["mission_patch_small"]
        missionPatch <- map["mission_patch"]
    }
}


