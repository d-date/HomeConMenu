//
//  MacOSBridge.swift
//  HomeMenu
//
//  Created by Yuichi Yoshida on 2022/03/02.
//

import Foundation
@objc(iOS2Mac)
public protocol iOS2Mac: NSObjectProtocol {
    init()
    var iosListener: mac2iOS? { get set }
    func didUpdate()
    func bringToFront()
    func didUpdate(chracteristicInfo: CharacteristicInfoProtocol)
}

@objc(mac2iOS)
public protocol mac2iOS: NSObjectProtocol {
    func reload(uniqueIdentifiers: [UUID])
    func getArray() -> [AccessoryInfoProtocol]
    func toggleValue(uniqueIdentifier: UUID)
    func openCamera(uniqueIdentifier: UUID)
    func updateColor(uniqueIdentifier: UUID, value: Double)
}
