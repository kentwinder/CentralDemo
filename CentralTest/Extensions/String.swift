//
//  String.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

extension String {
    func isPalindrome() -> Bool {
        let chars = Array(self.lowercased())
        var firstIndex = 0
        var lastIndex = chars.count - 1
        while lastIndex > firstIndex {
            if chars[firstIndex] != chars[lastIndex] {
                return false
            }
            firstIndex += 1
            lastIndex -= 1
        }
        
        return true
    }
}
