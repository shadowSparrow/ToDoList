//
//  LaunchViewController.swift
//  ToDoList
//
//  Created by Alexander Romanenko on 07.10.2020.
//  Copyright © 2020 Alexander Romanenko. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    @IBOutlet weak var imageFish: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        imageFish.image = UIImage(named: "RoundedIcon")
        UIView.animate(withDuration: 3, animations: {
        self.imageFish.transform = CGAffineTransform(rotationAngle: .pi)
        }) { (Bool) in
            
            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let secondVC = mainStoryboard.instantiateViewController(withIdentifier: "secondVC") as? TableViewController
            self.navigationController?.pushViewController(secondVC!, animated: true)
        }
    }
}
