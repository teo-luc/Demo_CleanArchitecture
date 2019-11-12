//
//  NSManagedObject+Ext.swift
//  NetworkPlatform
//
//  Created by Teqnological on 11/12/19.
//  Copyright © 2019 Luc Nguyen. All rights reserved.
//

import CoreData

extension NSManagedObject {
    public subscript(forKey: CodingKey) -> Any? {
        get {
             return self.value(forKey: forKey.stringValue)
        }
        set {
            self.setValue(newValue, forKey: forKey.stringValue)
        }
    }
}
