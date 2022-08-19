//
//  ViewController.swift
//  FloatyVC
//
//  Created by Zhaojie CHEN(陳昭潔) on 2022/8/19.
//

import UIKit

class ViewController: UIViewController{
    let floatVC = FloatVC()
    let viewModel = FloatVC.viewModel(
        fabDirection: .right,
        IntervalOfButtons: 10
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
