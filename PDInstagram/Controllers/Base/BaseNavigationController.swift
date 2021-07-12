//
//  BaseNavigationController.swift
//  PDSwift
//
//  Created by Peide Xiao on 9/22/20.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        addScreenEdgePanGesture();
      
        setupNavigationiBar()
    }
    
    private func setupNavigationiBar() {
        UINavigationBar.appearance().tintColor =  UIColor.purple

        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.AvenirNext(weight: .Medium, 20)]
        // UINavigationBar.appearance().setBackgroundImage(UIImage(named: "bg"), for: .default) // 设置背景图片
        // UINavigationBar.appearance().barTintColor = UIColor.red
        
        
        // 获取所有item  实例
        
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.AvenirNext(weight: .Medium, 15)], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.AvenirNext(weight: .Medium, 15)], for: .disabled)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let backButton = UIButton()
            backButton.setImage(UIImage(named: "back_black"), for: .normal)
            backButton.sizeToFit()
            backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)

        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    private func addScreenEdgePanGesture() {
        
        let recognizer: UIScreenEdgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePan(recognizer:)))
        recognizer.delegate = self
        recognizer.edges = UIRectEdge.left
        self.view.addGestureRecognizer(recognizer)
    }
    
    
    @objc private func edgePan(recognizer: UIScreenEdgePanGestureRecognizer) {
        self.popViewController(animated: true)
    }
    
    public func hide() {
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().backgroundColor = UIColor.clear
    }

    func largerTitle() {
        UINavigationBar.appearance().prefersLargeTitles = true
    }
    
    @objc func back() {
        self.popViewController(animated: true)
    }
}


extension BaseNavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.children.count > 1
    }
}
