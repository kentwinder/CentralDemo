//
//  SumIndexViewController.swift
//  CentralTest
//
//  Created by Kent Winder on 10/15/20.
//

import UIKit
import RxSwift

class SumIndexViewController: UIViewController {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    var viewModel: SumIndexViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
    }
    
    func setupViews() {
        
    }
    
    func setupViewModel() {
        viewModel = DefaultSumIndexViewModel()
        viewModel.message.drive(onNext: { [weak self] (message) in
            guard let self = self else { return }
            self.messageLabel.text = message
        }).disposed(by: disposeBag)
    }
    
    @IBAction func findMiddleIndex(_ sender: Any) {
        viewModel.findMiddleIndex(from: textField.text ?? "")
    }
}
