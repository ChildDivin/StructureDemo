//
//  Singleton.swift
//  KoloniKube_Swift
//
//  Created by Tops on 5/19/17.
//  Copyright © 2017 Self. All rights reserved.
//

import UIKit

class Singleton: NSObject {

    var is_LocationVisible = false
    var is_BookingVisible = false
    
    private override init() {
        
    }
    static let shared: Singleton = {
        let instance = Singleton()
        return instance
    }()
    
    var bikeData = ShareBikeKube()
    
    func parseDeviceJson(arr:NSArray,arrOut:NSMutableArray) -> Void {
        for dict in arr as! [NSDictionary]{
            let device = ShareDevice()
            device.strId = dict.object(forKey: "id") as? String ?? ""
            device.strAddress = dict.object(forKey: "address") as? String ?? ""
            device.strAvailableBike = StaticClass().getInterGer(value: dict.object(forKey: "available_bikes")  ?? "0")
            device.strAvailableKube = StaticClass().getInterGer(value: dict.object(forKey: "available_kubes")  ?? "0")
            
            device.strLat = Double(dict.object(forKey: "latitude") as? String ?? "0")!
            device.strLong = Double(dict.object(forKey: "longitude") as? String ?? "0")!
            device.strLocationName = dict.object(forKey: "location_name") as? String ?? ""
            device.strReview = dict.object(forKey: "total_review") as? String ?? ""
            device.strRating = StaticClass().getDouble(value: dict.object(forKey: "average_ratings") ?? "0")
            device.strAvgRating = StaticClass().getDouble(value: dict.object(forKey: "average_ratings") ?? "0")
            device.strKubeAvgPrice = StaticClass().getDouble(value: dict.object(forKey: "kube_average_price") ?? "0")
            device.strBikeAvgPrice = StaticClass().getDouble(value: dict.object(forKey: "bike_average_price") ?? "0")
            
            if let arrKube = dict["kube_list"] as? NSArray{
                for dictKube in arrKube as! [NSDictionary]{
                    let kube = ShareBikeKube()
                    kube.strId = dictKube.object(forKey: "id") as? String ?? ""
                    kube.strImg = dictKube.object(forKey: "image") as? String ?? ""
                    kube.strName = dictKube.object(forKey: "name") as? String ?? ""
                    kube.strObjName = dictKube.object(forKey: "object_name") as? String ?? ""
                    kube.strDeviceID = dictKube.object(forKey: "device_id") as? String ?? ""
                    kube.doublePrice = StaticClass().getDouble(value: dictKube.object(forKey: "price") ?? "0")
                    kube.strDistance = dictKube.object(forKey: "distance") as? String ?? "" //
                    kube.strBooked = dictKube.object(forKey: "is_booked") as? String ?? ""
                    kube.intType = 2 //kubes
                    device.arrKubes.add(kube)
                }
            }
            if let arrBike = dict["bike_list"] as? NSArray{
                for dictBike in arrBike as! [NSDictionary]{
                    let Bike = ShareBikeKube()
                    Bike.strId = dictBike.object(forKey: "id") as? String ?? ""
                    Bike.strImg = dictBike.object(forKey: "image") as? String ?? ""
                    Bike.strName = dictBike.object(forKey: "name") as? String ?? ""
                    Bike.strObjName = dictBike.object(forKey: "object_name") as? String ?? ""
                    Bike.doublePrice = StaticClass().getDouble(value: dictBike.object(forKey: "price") as? Double ?? 0.0)
                    Bike.strDistance = dictBike.object(forKey: "distance") as? String ?? ""
                    Bike.strDeviceID = dictBike.object(forKey: "device_id") as? String ?? ""
                    Bike.intType = 1
                    device.arrBikes.add(Bike)
                }
            }
            if let arrAmenities = dict["amenities"] as? NSArray{
                for dictKube in arrAmenities as! [NSDictionary]{
                    let kube = ShareAmenities()
                    kube.strId = dictKube.object(forKey: "id") as? String ?? ""
                    kube.strImage = dictKube.object(forKey: "image") as? String ?? ""
                    kube.strName = dictKube.object(forKey: "name") as? String ?? ""
                    device.arrAmenities.add(kube)
                }
            }
            
            if let arrImage = dict["location_image"] as? NSArray{
                for dictKube in arrImage as! [NSDictionary]{
                    let kube = ShareDeviceImage()
                    kube.strImage = dictKube.object(forKey: "image") as? String ?? ""
                    device.arrImage.add(kube)
                }
            }
            arrOut.add(device)
        }
    }
    
}
