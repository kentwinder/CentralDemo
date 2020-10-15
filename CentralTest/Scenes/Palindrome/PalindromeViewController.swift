//
//  PalindromeViewController.swift
//  CentralTest
//
//  Created by Kent Winder on 10/15/20.
//

import UIKit
import RxSwift

class PalindromeViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    var viewModel: PalindromeViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
    }
    
    func setupViews() {
        
    }
    
    func setupViewModel() {
        viewModel = DefaultPalindromeViewModel()
        viewModel.message.drive(onNext: { [weak self] (message) in
            guard let self = self else { return }
            self.messageLabel.text = message
        }).disposed(by: disposeBag)
    }
    
    @IBAction func checkPalindrome(_ sender: Any) {
        viewModel.checkPalindrome(for: textField.text ?? "")
    }
}
