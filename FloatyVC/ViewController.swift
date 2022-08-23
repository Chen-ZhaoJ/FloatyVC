//
//  ViewController.swift
//  FloatyVC
//
//  Created by Zhaojie CHEN(陳昭潔) on 2022/8/19.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate{
    let vc2 = ViewController2()
    let viewModel = FloatVC.ViewModel()
    let floatVC = FloatVC(initVM: FloatVC.ViewModel(
        fabDirection: .left,
        btnLeftOrRightSpace: 40,
        btnBottom: -50
    )) ?? FloatVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray2
        layout()
        testLable()
        createFloatVC()
    }
    
    func createFloatVC(){
        floatVC.createFAB(image: .img_close, color: .black)
        floatVC.createFAB(image: .img_message, title: "none", color: .yellow, target: #selector(sendMessage(_:)), atVC: self)
        floatVC.createFAB(image: .img_link, title: "collapseFAB", color: .yellow, target: #selector(toLink(_:)), atVC: self)
    }
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setImage(.img_add, for: .normal)
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .yellow
        btn.addTarget(self, action: #selector(showFloatVC(_:)), for: .touchUpInside)
        return btn
    }()
    
    func layout(){
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.widthAnchor.constraint(equalToConstant: viewModel.buttonSize),
                                     button.heightAnchor.constraint(equalToConstant: viewModel.buttonSize),
                                     button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
                                     button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)])
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
    
    @IBAction func sendMessage (_ sender: UIButton){
        print("one Button Clicked")
        floatVC.present(vc2, animated: true)
    }
    
    @IBAction func toLink (_ sender: UIButton){
        print("two Button Clicked")
        floatVC.collapseFAB()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            present(vc2, animated: true, completion: nil)
        }
    }
}
