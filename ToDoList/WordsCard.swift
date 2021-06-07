//
//  WordsCard.swift
//  ToDoList
//
//  Created by mac on 18.04.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//

import UIKit

class WordsCard: UIViewController, UINavigationControllerDelegate, UITextFieldDelegate {

    // MARK: - IBOtlets
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
   
    
    var addWordDelegate: AddNewWordDelegate!
    
    // MARK: - GlobalConnectionProperties
    var color = UIColor.black
    var wordText: String?
    var editedtext: String?
    var translationText = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - ElementInitialisation
        //DataPass
        
        
        if editedtext != nil {
            wordTextField.text = editedtext
        } else {
        wordTextField.text = wordText
        }
        
        //TexFieldsDelegate
        
        translationTextField.delegate = self
        
        
    //MARK: - ImageUserInterractionSettings
        
        //ImageViewUserInterection
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        imageView.addGestureRecognizer(tapGesture)
            // make sure imageView can be interacted with by user
        imageView.isUserInteractionEnabled = true
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //wordText = wordTextField.text
        wordTextField.delegate = self
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //MARK: - UIElementsDesign
            
            //BackGround Design
            backGroundView.backgroundColor = color
            backGroundView.alpha = 1
            
            //TextFieldsDesign
            textFieldDesign(element:translationTextField)
            textFieldDesign(element:wordTextField)
        
            //ImageViewDesign
            imageView.image = UIImage(named: "violetCirclePles")
            imageViewDesign(element: imageView)
           
    }
    
    // MARK: - @ObjFuncs
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        
        UIView.animate(withDuration: 0.1, animations: {
            self.imageView.alpha = 0.0
            self.imageView.alpha = 1.0
        }) { (Bool) in
        
            if (gesture.view as? UIImageView) != nil {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)
            }
}
    }
    
    @IBAction func backTotableViewButton(_ sender: Any) {
        
    
        

        guard let text = wordTextField.text else { return }
        
        if text != "" {
        
        if let delegate = addWordDelegate {
            print("DelegateInitiated")
            
            if  !delegate.isItemExist(item:text) {
                
                if let editedText = editedtext {
                 
                print("Hello    \(editedText)")
    
                delegate.shouldReplace(item: editedText, withItem: text)
    
                    // TODO: - ImplementReplaceMethod
                
                } else {
                    
                    delegate.addWord(word: text)
                }
                
                navigationController?.popViewController(animated: true)
                
                
             
            } else {
            
                let alert = UIAlertController(title: "Item exists", message: "\(wordTextField.text) already exists in your shopping list.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        } else {
            print("DelegateIsNotInitiated")
        }
}

    }
      
        
  /*
     // MARK: - UITextFieldDelegate
     extension EditItemViewController: UITextFieldDelegate {
         func textFieldShouldReturn(_ textField: UITextField) -> Bool {
             saveItem(self)
             return true
         }
     }
     
 */
    
    
// MARK: - TextfieldDelegateMethodes
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //
        textField.resignFirstResponder()
        textField.isHidden = false
        
        backTotableViewButton(self)
        
        
        if textField == wordTextField{
            textField.resignFirstResponder()
            textField.isHidden = false
            
            //wordLabel.text = wordTextField.text
        } else if textField == translationTextField {
            textField.resignFirstResponder()
            textField.isHidden = false
            
            //wordTextField.becomeFirstResponder()
            //translationLabel.isHidden = false
            //translationLabel.text = translationTextField.text
        } else {
            print("Some stange is Happening")
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    
    }
}


// MARK: - ImagePickerControllerDelegate
extension WordsCard: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
