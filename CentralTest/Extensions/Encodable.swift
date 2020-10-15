//
//  Encodable.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
}
