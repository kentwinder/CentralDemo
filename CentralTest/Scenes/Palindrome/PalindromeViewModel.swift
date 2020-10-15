//
//  PalindromeViewModel.swift
//  CentralTest
//
//  Created by Kent Winder on 10/15/20.
//

import RxCocoa
import RxSwift

protocol PalindromeViewModelInput {
    func checkPalindrome(for string: String)
}

protocol PalindromeViewModelOutput {
    var message: Driver<String> { get }
}

protocol PalindromeViewModel: PalindromeViewModelInput, PalindromeViewModelOutput {}

open class DefaultPalindromeViewModel: PalindromeViewModel {
    private let messageRelay = BehaviorRelay(value: "")

    // MARK: - Output
    var message: Driver<String> {
        return messageRelay.asDriver()
    }
}

// MARK: - Input
extension DefaultPalindromeViewModel {
    func checkPalindrome(for string: String) {
        guard !string.isEmpty else { return }
        
        if string.isPalindrome() {
            messageRelay.accept("\(string) is a palindrome")
        } else {
            messageRelay.accept("\(string) isn't a palindrome")
        }
    }
}
