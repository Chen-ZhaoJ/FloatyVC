//
//  ViewController.swift
//  FloatyVC
//
//  Created by Zhaojie CHEN(陳昭潔) on 2022/8/19.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate{
    let floatVC = FloatVC()
    let vc2 = ViewController2()
    let viewModel = FloatVC.viewModel(
        fabDirection: .left
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray2
        layout()
        testLable()
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
        btn.addTarget(self, action: #selector(showFloatVC(_:)), for: .touchUpInside)
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
    
    func testLable(){
        let testlable:UILabel = UILabel()
        testlable.text = "測試測試測試"
        testlable.textColor = .systemYellow
        view.addSubview(testlable)
        testlable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([testlable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     testlable.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
}

extension ViewController {
    @IBAction func showFloatVC(_ sender: UIButton){
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            present(vc2, animated: true, completion: nil)
        }
    }
}
