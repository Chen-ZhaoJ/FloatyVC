//
//  ViewController.swift
//  FloatyVC
//
//  Created by Zhaojie CHEN(陳昭潔) on 2022/8/19.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate{
    let floatVC = FloatVC()
    let viewModel = FloatVC.viewModel(
        fabDirection: .left
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray2
        layout()
        setFloatVC()
    }
    
    func setFloatVC(){
        floatVC.createCloseButton(initVM: viewModel, image: .img_close, color: .black)
        floatVC.createOtherButton(image: .img_message, title: "none", color: .yellow, target: #selector(sendMessage(_:)), atVC: self)
        floatVC.createOtherButton(image: .img_link, title: "collapseFAB", color: .yellow, target: #selector(toLink(_:)), atVC: self)
    }
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("show", for: .normal)
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .black
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(show(_:)), for: .touchUpInside)
        return btn
    }()
    
    func layout(){
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.widthAnchor.constraint(equalToConstant: viewModel.buttonSize),
                                     button.heightAnchor.constraint(equalToConstant: viewModel.buttonSize),
                                     button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: floatVC.getLeftLead()),
                                     button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: viewModel.viewBottom)])
    }
}

extension ViewController {
    @IBAction func show(_ sender: UIButton){
        floatVC.modalPresentationStyle = .overFullScreen
        present(floatVC, animated: false)
    }
    
    @objc func backThisVC(){
        floatVC.collapseFAB()
    }
    
    @IBAction func sendMessage (_ sender: UIButton){
        print("one Button Clicked")
    }
    
    @IBAction func toLink (_ sender: UIButton){
        print("two Button Clicked")
        floatVC.collapseFAB()
    }
}
