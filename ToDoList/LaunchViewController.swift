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
        imageFish.image = UIImage(named: "whiteFingerPrint")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animate(withDuration: 1, animations: {
            self.imageFish.transform = CGAffineTransform(rotationAngle: .pi/2)
        }) { (Bool) in
            let mainStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
            let secondVC = mainStoryboard.instantiateViewController(withIdentifier: "secondVC") as? TableViewController
            self.navigationController?.pushViewController(secondVC!, animated: true)
        
    }
   }
}
