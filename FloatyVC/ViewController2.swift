//
//  ViewController2.swift
//  FloatyVC
//
//  Created by Zhaojie CHEN(陳昭潔) on 2022/8/22.
//

import UIKit

class ViewController2: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        layout()
    }
    
    lazy var button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Back", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(back(_:)), for: .touchUpInside)
        return btn
    }()
    
    func layout(){
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
                                     button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)])
    }
    
    @IBAction func back(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
        print("back to vc")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
