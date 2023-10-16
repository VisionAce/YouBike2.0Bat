//
//  YouBikeData.swift
//  YouBike2.0
//
//  Created by 褚宣德 on 2023/10/9.
//
import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let sno, sna: String
    let tot, sbi: Int
    let sarea, mday: String
    let lat, lng: Double
    let ar, sareaen, snaen, aren: String
    let bemp: Int
    let act, srcUpdateTime, updateTime, infoTime: String
    let infoDate: String
    var id: String { sno }
}

typealias Welcome = [WelcomeElement]


enum Constants {
    static let youBikeAPiKey = "https://tcgbusfs.blob.core.windows.net/dotapp/youbike/v2/youbike_immediate.json"
}
