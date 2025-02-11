//
//  MenuFromUUID.swift
//  macOSBridge
//
//  Created by Yuichi Yoshida on 2022/03/20.
//

import Foundation

protocol MenuFromUUID {
    func bind(with uniqueIdentifier: UUID) -> Bool
    func UUIDs() -> [UUID]
}
