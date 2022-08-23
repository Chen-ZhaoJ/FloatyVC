//
//  ViewController.swift
//  FloatyVC
//
//  Created by Zhaojie CHEN(陳昭潔) on 2022/8/19.
//

import UIKit

final class FloatVC: UIViewController, CAAnimationDelegate{
    enum FabDirection {
        case left
        case right
    }
    struct ViewModel{
        var fabDirection: FabDirection = .left
        var btnLeftOrRightSpace: CGFloat = 0
        var btnBottom: CGFloat = 0
        var buttonSize: CGFloat = 50
        var lblTextSize: Double = 20
        var lblTextColor: UIColor = UIColor.systemYellow
        var maskAlpha: CGFloat = 0.5
        var maskColor: UIColor = UIColor.black
        var rotateExpandDuration: Double = 0.3
        var rotateCollapseDuration: Double = 0.3
        var positionExpandDuration: Double = 0.3
        var positionCollapseDuration: Double = 0.3
        var IntervalOfButtons: CGFloat = 5
    }
    private var vm = ViewModel()
    private var isExpand: Bool = false
    private var views: [UIView] = []
    private var btns: [UIButton] = []
    private var lbls: [UILabel] = []
    private var bottomAnchors: [NSLayoutConstraint] = []
    private let customMaskView: UIView = UIView()
    
    func createCloseButton(initVM: ViewModel, image: UIImage, title: String? = nil, color: UIColor, target: Selector? = nil, atVC: Any? = nil){
        guard views.count == 0 else {
            print("add another TopButton: Initialize another FloatVC with a different variable name")
            print("add other buttons that are not the top: Use createOtherButton")
            return
        }
        vm.fabDirection = initVM.fabDirection
        vm.btnLeftOrRightSpace = initVM.btnLeftOrRightSpace
        vm.btnBottom = initVM.btnBottom
        vm.buttonSize = initVM.buttonSize
        vm.lblTextSize = initVM.lblTextSize
        vm.lblTextColor = initVM.lblTextColor
        vm.maskAlpha = initVM.maskAlpha
        vm.maskColor = initVM.maskColor
        vm.rotateExpandDuration = initVM.rotateExpandDuration
        vm.rotateCollapseDuration = initVM.rotateCollapseDuration
        vm.IntervalOfButtons = initVM.IntervalOfButtons
        
        createView(index: 0)
        createLabel(index: 0, title: title ?? "")
        createButton(image: image, index: 0, color: color,target: target, atVC: atVC)
    }
    
    func createOtherButton(image: UIImage, title: String? = nil, color: UIColor, target: Selector? = nil, atVC: Any? = nil){
        guard views.count>0 else {
            print("must createTopButton first")
            return
        }
        let index = views.count
        createView(index: index)
        createLabel(index: index, title: title ?? "")
        createButton(image: image, index: index, color: color,target: target, atVC: atVC)
    }
        
    func collapseFAB(){
        guard isExpand == true else { return }
        collapse()
    }
    
    private func createView(index: Int){
        let myView: UIView = UIView()
        views.insert(myView, at: index)

        if index != 0 {
            view.insertSubview(views[index], belowSubview: views[index-1])
        }else{
            view.insertSubview(views[index], at: 1)
        }
        views[index].translatesAutoresizingMaskIntoConstraints = false
        let bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
        bottomAnchors.insert(bottomConstraint, at: index)
        bottomAnchors[index] = views[index].bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: vm.btnBottom)
        NSLayoutConstraint.activate([views[index].widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0),
                                     views[index].heightAnchor.constraint(equalToConstant: vm.buttonSize),
                                     views[index].leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                     bottomAnchors[index]])
    }
    
    private func createButton(image: UIImage, index: Int, color: UIColor, target: Selector?, atVC: Any?){
        let button: UIButton = UIButton()
        btns.insert(button, at: index)
        btns[index].setImage(image, for: .normal)
        btns[index].layer.cornerRadius = 25
        btns[index].backgroundColor = color
        
        views[index].addSubview(btns[index])
        btns[index].translatesAutoresizingMaskIntoConstraints = false
        var lead: CGFloat = 0
        if vm.fabDirection == .left{
            lead = vm.btnLeftOrRightSpace
        }else{
            lead = UIScreen.main.bounds.size.width-vm.btnLeftOrRightSpace-vm.buttonSize
        }
        NSLayoutConstraint.activate([btns[index].widthAnchor.constraint(equalToConstant: vm.buttonSize),
                                     btns[index].heightAnchor.constraint(equalToConstant: vm.buttonSize),
                                     btns[index].leadingAnchor.constraint(equalTo: views[index].leadingAnchor, constant: lead),
                                     btns[index].bottomAnchor.constraint(equalTo: views[index].bottomAnchor, constant: 0)])
        if index == 0 {
            btns[0].addTarget(self, action: #selector(collapse), for: UIControl.Event.touchUpInside)
        }
        guard target != nil else { return }
        btns[index].addTarget(atVC, action: target ?? Selector(String()), for: UIControl.Event.touchUpInside)
    }
    
    private func createLabel(index: Int, title: String){
        let label: UILabel = UILabel()
        lbls.insert(label, at: index)
        lbls[index].text = title
        lbls[index].textColor = vm.lblTextColor
        lbls[index].font = UIFont.systemFont(ofSize: vm.lblTextSize)
        lbls[index].isHidden = true
        
        views[index].addSubview(lbls[index])
        lbls[index].translatesAutoresizingMaskIntoConstraints = false
        var lblLeading: CGFloat = 55
        if vm.fabDirection == .left{
            lblLeading = vm.buttonSize+vm.btnLeftOrRightSpace+5
            lbls[index].textAlignment = .left
        }else{
            lblLeading = -5-vm.btnLeftOrRightSpace
            lbls[index].textAlignment = .right
        }
        NSLayoutConstraint.activate([lbls[index].centerYAnchor.constraint(equalTo: views[index].centerYAnchor, constant: 0),
                                     lbls[index].widthAnchor.constraint(equalTo: views[index].widthAnchor, constant: -vm.buttonSize),
                                     lbls[index].leadingAnchor.constraint(equalTo: views[index].leadingAnchor, constant: lblLeading)])
    }

    private func initialMask(){
        customMaskView.backgroundColor = vm.maskColor.withAlphaComponent(vm.maskAlpha)
        view.insertSubview(customMaskView, at: 0)
        customMaskView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([customMaskView.widthAnchor.constraint(equalTo: view.widthAnchor),
                                     customMaskView.heightAnchor.constraint(equalTo: view.heightAnchor),
                                     customMaskView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     customMaskView.centerYAnchor.constraint(equalTo: view.centerYAnchor)])
    }
    
    @objc private func expand(){
        if vm.fabDirection == .left {
            animationRotate(duration: vm.rotateExpandDuration, toValue: Double.pi, repeatCount: 0.5, btn:btns[0]) //順時針轉
        }else{
            animationRotate(duration: vm.rotateExpandDuration, toValue: Double.pi, repeatCount: -0.5, btn:btns[0]) //順時針轉
        }
        
        for i in 1 ..< views.count{ //顯示字、把button展開
            lbls[i].isHidden = false
            bottomAnchors[i].constant = bottomAnchors[i].constant-CGFloat(i)*(btns[0].frame.width+vm.IntervalOfButtons)
            let from = [views[0].frame.midX,views[0].frame.midY]
            let to = [views[0].frame.midX,views[0].frame.midY-CGFloat(i)*(btns[0].frame.width+vm.IntervalOfButtons)]
            animationPosition(duration: vm.positionExpandDuration, fromValue: from, toValue: to, index: i)
        }
        isExpand = !isExpand
    }
    
    @objc private func collapse(){
        if vm.fabDirection == .left {
            animationRotate(duration: vm.rotateCollapseDuration, toValue: 0, repeatCount: -0.5, btn:btns[0]) //逆時針轉
        }else{
            animationRotate(duration: vm.rotateCollapseDuration, toValue: 0, repeatCount: 0.5, btn:btns[0]) //逆時針轉
        }
        
        for i in 1 ..< views.count{ //把button收回、隱藏字
            bottomAnchors[i].constant = vm.btnBottom
            let from = [views[0].frame.midX,views[0].frame.midY-CGFloat(i)*(btns[0].frame.width+vm.IntervalOfButtons)]
            let to = [views[0].frame.midX,views[0].frame.midY]
            animationPosition(duration: vm.positionCollapseDuration, fromValue: from, toValue: to, index: i)
            lbls[i].isHidden = true
        }
        isExpand = !isExpand
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if isExpand == false {
            self.dismiss(animated: false)
        }
    }
    
    private func animationRotate(duration: Double, toValue: Double, repeatCount: Float, btn: UIButton){ //旋轉動畫
        let animRotate = CABasicAnimation(keyPath: "transform.rotation")
        animRotate.delegate = self
        animRotate.duration = duration //動畫速度
        animRotate.isRemovedOnCompletion = false //結束時不回復原樣
        animRotate.fillMode = CAMediaTimingFillMode.forwards //讓layer停在toValue
        animRotate.toValue = toValue //設定動畫結束值
        animRotate.repeatCount = repeatCount //旋轉次數（正1為順時針一圈，負為逆時針）
        btn.imageView?.layer.add(animRotate, forKey: nil)
    }
    
    private func animationPosition(duration: Double, fromValue: [CGFloat], toValue: [CGFloat], index: Int){ //位移動畫
        let animPosition = CABasicAnimation(keyPath: "position")
        animPosition.duration = duration
        animPosition.isRemovedOnCompletion = false
        animPosition.fillMode = CAMediaTimingFillMode.forwards
        animPosition.fromValue = fromValue
        animPosition.toValue = toValue
        views[index].layer.add(animPosition, forKey: nil)
    }
        
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: self.view) else { return }
        guard !btns[0].frame.contains(location) && isExpand == true else { return } //位置不在FAB且FAB為展開時
        collapse()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        initialMask()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard btns.count > 0 else {
            print("must add button on FloatVC first")
            return
        }
        expand()
    }
}
