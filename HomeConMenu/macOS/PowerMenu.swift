//
//  PowerMenu.swift
//  macOSBridge
//
//  Created by Yuichi Yoshida on 2022/03/20.
//

import Cocoa

class PowerMenu: NSMenuItem, MenuFromUUID {
    func UUIDs() -> [UUID] {
        return [powerCharacteristicIdentifier]
    }
    
    func bind(with uniqueIdentifier: UUID) -> Bool {
        return powerCharacteristicIdentifier == uniqueIdentifier
    }
    
    let powerCharacteristicIdentifier: UUID
    var mac2ios: mac2iOS?
    
    @IBAction func toggle(sender: NSMenuItem) {
        self.mac2ios?.toggleValue(uniqueIdentifier: powerCharacteristicIdentifier)
        self.state = (self.state == .on) ? .off : .on
    }
    
    func update(value: Int) {
        self.state = (value == 1) ? .on : .off
    }
        
    init?(accessoryInfo: AccessoryInfoProtocol, serviceInfo: ServiceInfoProtocol, mac2ios: mac2iOS?) {
        //mac2ios: mac2iOS?, title: Any?, uniqueIdentifier: UUID, state: Any?, type: ServiceType) {
        guard let powerStateChara = serviceInfo.characteristics.first(where: { obj in
            obj.type == .powerState
        }) else { return nil }
        guard let nameChara = serviceInfo.characteristics.first(where: { obj in
            obj.type == .name
        }) else { return nil }
        
        self.mac2ios = mac2ios
        self.powerCharacteristicIdentifier = powerStateChara.uniqueIdentifier
        if let name = nameChara.value as? String {
            super.init(title: name, action: nil, keyEquivalent: "")
        } else {
            super.init(title: "", action: nil, keyEquivalent: "")
        }
        if let number = powerStateChara.value as? Int {
            self.state = (number == 0) ? .off : .on
        }
        if serviceInfo.type == .lightbulb {
            self.image = NSImage(systemSymbolName: "lightbulb", accessibilityDescription: nil)
        } else {
            self.image = NSImage(systemSymbolName: "powerplug", accessibilityDescription: nil)
        }

        self.action = #selector(PowerMenu.toggle(sender:))
        self.target = self
    }
    
    override init(title string: String, action selector: Selector?, keyEquivalent charCode: String) {
        self.powerCharacteristicIdentifier = UUID()
        super.init(title: string, action: selector, keyEquivalent: charCode)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
