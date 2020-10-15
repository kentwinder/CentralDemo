//
//  SumIndexViewModel.swift
//  CentralTest
//
//  Created by Kent Winder on 10/15/20.
//

import RxCocoa
import RxSwift

protocol SumIndexViewModelInput {
    func findMiddleIndex(from data: String)
}

protocol SumIndexViewModelOutput {
    var message: Driver<String> { get }
}

protocol SumIndexViewModel: SumIndexViewModelInput, SumIndexViewModelOutput {}

open class DefaultSumIndexViewModel: SumIndexViewModel {
    private let messageRelay = BehaviorRelay(value: "")

    // MARK: - Output
    var message: Driver<String> {
        return messageRelay.asDriver()
    }
}

// MARK: - Input
extension DefaultSumIndexViewModel {
    func findMiddleIndex(from data: String) {
        let numbers = data.components(separatedBy: ",").compactMap {
            Int($0.trimmingCharacters(in: .whitespaces))
        }
        
        if let index = indexWhereLeftSumIsEqualRightSumFrom(numbers: numbers) {
            messageRelay.accept("Middle index is \(index)")
        } else {
            messageRelay.accept("Index not found")
        }
    }
    
    private func indexWhereLeftSumIsEqualRightSumFrom(numbers: [Int]) -> Int? {
        let totalNumber = numbers.count
        guard totalNumber > 2 else { return nil }
        
        var leftIndex = 0
        var rightIndex = totalNumber - 1
        
        var leftSum = 0
        var rightSum = 0
        while leftIndex < rightIndex {
            leftSum += numbers[leftIndex]
            rightSum += numbers[rightIndex]
            
            while leftSum < rightSum && leftIndex < rightIndex {
                leftIndex += 1
                leftSum += numbers[leftIndex]
            }
            
            while rightSum < leftSum && leftIndex < rightIndex {
                rightIndex -= 1
                rightSum += numbers[rightIndex]
            }
            
            if leftIndex != rightIndex {
                leftIndex += 1
                rightIndex -= 1
            }
        }
        
        if leftSum == rightSum {
            return leftIndex
        }
        
        return nil
    }
}
