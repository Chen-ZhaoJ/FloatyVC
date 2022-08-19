//
//  FABView.swift
//  FloatyVC
//
//  Created by Zhaojie CHEN(陳昭潔) on 2022/8/19.
//

import Foundation
import UIKit

class FABView: UIView{
    private var btns: [UIButton] = []
    private var lbls: [UILabel] = []
    
    func createTopButton(initVM: viewModel, collapse: UIImage, expand: UIImage, target: Selector?, atVC: Any?){
        guard views.count == 0 else {
            print("add another TopButton: Initialize another FloatingActionButtonView with a different variable name")
            print("add other buttons that are not the top: Use createOtherButton")
            return
        }
        vm.fabDirection = initVM.fabDirection
        vm.viewLeading = initVM.viewLeading
        vm.viewBottom = initVM.viewBottom
        vm.buttonSize = initVM.buttonSize
        vm.fabExpandColor = initVM.fabExpandColor
        vm.fabCollapseColor = initVM.fabCollapseColor
        vm.lblTextSize = initVM.lblTextSize
        vm.lblTextColor = initVM.lblTextColor
        vm.maskAlpha = initVM.maskAlpha
        vm.maskColor = initVM.maskColor
        vm.rotateExpandDuration = initVM.rotateExpandDuration
        vm.rotateCollapseDuration = initVM.rotateCollapseDuration
        vm.IntervalOfButtons = initVM.IntervalOfButtons
        
        createView(index: 0)
        createLabel(index: 0, title: "")
        createButton(image: collapse, index: 0, target: target, atVC: atVC)
        btns[0].addTarget(self, action: #selector(clickFAB(_:)), for: UIControl.Event.touchUpInside)
        initialMask()
        collapseImage = collapse
        expandImage = expand
    }
    
    func createOtherButton(image: UIImage, title: String, target: Selector?, atVC: Any?){
        guard views.count>0 else {
            print("you must createTopButton first")
            return
        }
        let index = views.count
        createView(index: index)
        createLabel(index: index, title: title)
        createButton(image: image, index: index, target: target, atVC: atVC)
    }
}
