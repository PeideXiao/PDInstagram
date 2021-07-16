//
//  ViewController.swift
//  BarDemo0714
//
//  Created by User on 7/14/21.
//

import UIKit

class FacebookViewController: UIViewController {
    
    @IBOutlet weak var scrollViewLinked: UIScrollView!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subMenuButton: UIButton!
    @IBOutlet weak var yellowView: UIView!
    @IBOutlet weak var purpleView: UIView!
    @IBOutlet weak var ptopConstraint: NSLayoutConstraint!
    
    var isExpanded: Bool = false
    let menuWidth: CGFloat = 3/4 * Screen.Width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
    }
    
    
    @IBAction @objc func showMenu(sender: UIButton) {
        self.maskView.isHidden = false
        self.setSlideOutViews(with: true)
    }
    
    @objc func dismissMenuView(recognizer: UITapGestureRecognizer) {
        self.setSlideOutViews(with: false)
    }
    
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: [.curveEaseIn]) {
            self.ptopConstraint.constant = 300.0
            self.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [.curveLinear]) {
                self.orangeView.transform = CGAffineTransform(translationX: 100, y: 200)
            } completion: { _ in
                
            }
        }
    }
    
    
    @objc func pan(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.translation(in: self.scrollViewLinked)
        let ratio = point.x / menuWidth
        
        switch recognizer.state {
        case .began:
            if (self.maskView.isHidden) {
                self.maskView.isHidden = false
            }
            
        case .changed:
            if !self.isExpanded && point.x > 0 {
                tabBarController!.view.frame.origin.x = point.x
                self.menuView.frame.origin.x = point.x - self.menuWidth
                self.maskView.alpha = ratio * 0.3
            } else if ( self.isExpanded && point.x < 0 ) {
                tabBarController?.view.frame.origin.x = menuWidth + point.x
                self.menuView.frame.origin.x = point.x
                self.maskView.alpha = (1 - ratio) * 0.3
            }
            
        case .ended:
            self.setSlideOutViews(with: self.isExpanded ? abs(point.x) <= menuWidth/4 : point.x > menuWidth/4)
            
        default:
            print("default")
        }
    }
    
    
    func setSlideOutViews(with expanded: Bool) {
        if expanded {
            self.isExpanded = true
            self.updateSlideOutView()
        } else {
            self.isExpanded = false
            self.updateSlideOutView { _ in
                self.maskView.isHidden = true
            }
        }
    }
    
    func updateSlideOutView(completion:((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
            self.tabBarController!.view.frame.origin.x = self.isExpanded ? self.menuWidth : 0
            self.menuView.frame.origin.x = self.isExpanded ? 0 : -self.menuWidth
            self.maskView.alpha = self.isExpanded ? 0.3 : 0
        }, completion: completion)
    }
    
    
    lazy var menuView: UIView = {
        
        guard let profileView = Bundle.main.loadNibNamed("ProfileView", owner: nil, options: nil)?.first as? ProfileView else {
            return UIView()
        }
        profileView.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: Screen.Height)
        profileView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:))))
        return profileView
    }()
    
    lazy var maskView: UIView = {
        let maskV = UIView(frame: CGRect(x: 0, y: 0, width: Screen.Width, height: Screen.Height))
        maskV.backgroundColor = UIColor.black
        maskV.alpha = 0
        maskV.isHidden = true
        maskV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenuView(recognizer:))))
        maskV.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:))))
        return maskV
    }()
    
    lazy var orangeView: UIView = {
        let imageV = UIImageView(frame: CGRect(x: 0, y: 200, width: 100, height: 40))
        imageV.contentMode = .scaleAspectFill
        imageV.image = UIImage(named: "facebook")
        return imageV
    }()
    
    /*
     ranslatesAutoresizingMaskIntoConstraints needs to be set to false when:
     
     You Create a UIView-based object in code (Storyboard/NIB will set it for you if the file has autolayout enabled),
     And you want to use auto layout for this view rather than frame-based layout,
     And the view will be added to a view hierarchy that is using auto layout.
     
     
     For programmatically created view default is true and for views from Interface Builder default is false
     
     If the property is (or set to) True, the system automatically creates a set of constraints based on the view’s frame and its autoresizing mask. And if you add your own constraints, they inevitably conflict with the autogenerated constraints. This creates an unsatisfiable layout. So When programmatically instantiating views, be sure to set their translatesAutoresizingMaskIntoConstraints property to NO.
     
     */
    func configureSubviews() {
        
        // contentInset
        let _ = scrollViewLinked.contentInset
        
        // titleView
        let titleView = UIView(frame: CGRect(x: 0, y: topBarHeight + 8, width: Screen.Width, height: 44))
        navigationItem.titleView = titleView
        
        let menuButton = UIButton()
        menuButton.setImage(UIImage(named: "menu"), for: .normal)
        menuButton.addTarget(self, action: #selector(showMenu(sender:)), for: .touchUpInside)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(menuButton)
        
        NSLayoutConstraint.activate([
            menuButton.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 0),
            menuButton.leftAnchor.constraint(equalTo: titleView.leftAnchor, constant: 5),
            menuButton.widthAnchor.constraint(equalToConstant: 20),
            menuButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        let imageV = UIImageView(image: UIImage(named: "facebook"))
        imageV.contentMode = .scaleAspectFill
        titleView.addSubview(imageV)
        imageV.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageV.leftAnchor.constraint(equalTo: menuButton.rightAnchor, constant: 0),
            imageV.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            imageV.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        let settingBtn = UIButton()
        settingBtn.translatesAutoresizingMaskIntoConstraints = false
        settingBtn.setImage(UIImage(named: "settings"), for: .normal)
        
        titleView.addSubview(settingBtn)
        
        NSLayoutConstraint.activate([
            settingBtn.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 0),
            settingBtn.rightAnchor.constraint(equalTo: titleView.rightAnchor, constant: 0),
            settingBtn.heightAnchor.constraint(equalToConstant: 25),
            settingBtn.widthAnchor.constraint(equalToConstant: 25)
        ])
        
        
        // menuView
        guard let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            assertionFailure("delegate is nil")
            return
        }
        
        tabBarController?.view.addSubview(self.maskView)
        delegate.window?.addSubview(self.menuView)
        
        
        // logoView
        view.addSubview(self.orangeView)
        
        
        // UIPanGestureRecognizer
        
        let panGestureR = UIPanGestureRecognizer(target: self, action: #selector(pan(recognizer:)))
        panGestureR.delegate = self
        view.addGestureRecognizer(panGestureR)
    }
}

extension FacebookViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let left: CGFloat = 150.0
        let top: CGFloat = 100.0
        
        let contentOffsetY = scrollView.contentOffset.y
        let y = topBarHeight + contentOffsetY
        self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0, y: min(0, -y))
        let ratio: CGFloat = y/topBarHeight
        navigationItem.titleView?.alpha = max(0, 1.0 - ratio)
        
        // yeallow view animate to the navigation bar
        if (contentOffsetY >= 0) {
            let r1 = min(contentOffsetY / top, 1)
            leftConstraint.constant = left * (1 - r1)
            titleLabel.alpha = max(0, r1)
            subMenuButton.alpha = max(0,r1)
            
            
            if contentOffsetY >= top {
                topConstraint.constant = contentOffsetY
            }
        } else {
            leftConstraint.constant = left
            titleLabel.alpha = 0
            subMenuButton.alpha = 0
        }
    }
}


extension FacebookViewController: UIGestureRecognizerDelegate {
    
}
