//
//  ViewController.swift
//  FloatyVC
//
//  Created by Zhaojie CHEN(陳昭潔) on 2022/8/19.
//

import UIKit

class ViewController: UIViewController{
    let vc2 = ViewController2()
    let viewModel = FloatVC.ViewModel()
    let floatVC = FloatVC(fabDirection: .right)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray2
        layout()
        testLable()
        createFloatVC()
    }
    
    func createFloatVC(){
        floatVC.createFAB(image: .img_close, btnColor: .black)
        floatVC.createFAB(image: .img_message, title: "push vc2", btnColor: .yellow, lblColor: .yellow, target: #selector(sendMessage(_:)), atVC: self)
        floatVC.createFAB(image: .img_link, title: "present vc2", btnColor: .yellow, lblColor: .yellow, target: #selector(toLink(_:)), atVC: self)
        floatVC.createFAB(image: .img_add, title: "no collapse", btnColor: .yellow, lblColor: .yellow, target: #selector(none(_:)) , atVC: self)
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
        NSLayoutConstraint.activate([button.widthAnchor.constraint(equalToConstant: viewModel.btnSize),
                                     button.heightAnchor.constraint(equalToConstant: viewModel.btnSize),
                                     button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                     button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)])
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
        present(floatVC, animated: false)
    }
    
    @IBAction func sendMessage (_ sender: UIButton){
        print("one Button Clicked")
        floatVC.collapseFAB()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            navigationController?.pushViewController(vc2, animated: true)
        }
    }
    
    @IBAction func toLink (_ sender: UIButton){
        print("two Button Clicked")
        floatVC.collapseFAB()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            present(vc2, animated: true, completion: nil)
        }
    }

    @IBAction func none (_ sender: UIButton){
        print("three Button Clicked")
    }
}
