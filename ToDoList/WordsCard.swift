//
//  WordsCard.swift
//  ToDoList
//
//  Created by mac on 18.04.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//

import UIKit

class WordsCard: UIViewController, UITextFieldDelegate {

    // MARK: - IBOtlets
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var secondImageView: UIImageView!
    
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var delete: UIButton!
    
    
    var addWordDelegate: AddNewWordDelegate!
    
    // MARK: - GlobalConnectionProperties
    var color = UIColor.black
    var wordText: String?
    var editedtext: String?
    var editedTranlation: String?
    var translationText: String?
    var image: UIImage?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - ElementInitialisation
        
        
        //DataPass
        
        
        if editedtext != nil {
            wordTextField.text = editedtext
            imageView.image = image
        } else {
        wordTextField.text = wordText
        }
        
        if editedTranlation != nil {
            translationTextField.text = editedTranlation
            imageView.image = image
        } else {
            translationTextField.text = translationText
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
            //imageView.image = UIImage(named: "")
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
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
            }
}
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        guard let editedText = editedtext else { return}
        addWordDelegate.deleteItem(name: editedtext!)
        navigationController?.popViewController(animated:true)
    }
    
    @IBAction func backTotableViewButton(_ sender: Any) {
        guard let text = wordTextField.text else { return }
        guard let translation = translationTextField.text else {return}
        //guard let image = imageView.image else {return}
        
        if text != "" {
        
        if let delegate = addWordDelegate {
            print("DelegateInitiated")
            
            if  !delegate.isItemExist(item:text, translation: translation)
            
            {
                
                if editedtext != nil || editedTranlation != nil {
                
                var editedText = editedtext
                print("Hello \(editedText)")
                
                delegate.shouldReplace(item: editedText!, withItem: text)
                
                var edTranslation = editedTranlation
                print("Hello\(edTranslation)")
        
                delegate.translationReplace(translation: edTranslation!, with: translation)

                }
                
                else {
                    
                    if translationTextField == nil {
                        
                        var data: Data?
                        if let image = imageView.image {
                            data = image.pngData()
                            print("ImageViewPicked")
                        } else {
                            let image = UIImage(named: "circlePlus")
                            data = image?.pngData()
                            print("ImageViewNotPicked")
                        }
                        
                        delegate.addWord(word: text, translation: "Translation", image: data!)
                      
                    } else {
                        
                        var data: Data?
                        if let image = imageView.image {
                            data = image.pngData()
                        
                        } else {
                            
                            let image = UIImage(named: "circlePlus")
                            data = image?.pngData()
                            
                        }
                        delegate.addWord(word: text, translation: translation, image:data!)
    
                    }
                }
                
                navigationController?.popViewController(animated: true)
                
            } else {
            
                let alert = UIAlertController(title: "Item exists", message: "\(wordTextField.text, translationTextField.text) already exists in your shopping list.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style:.default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
                
        } else {
            print("DelegateIsNotInitiated")
        }
}
    }
      
    
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
        
        } else {
            print("Some stange is Happening")
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
    



// MARK: - ImagePickerControllerDelegate
extension WordsCard: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            //secondImageView.image = image
            imageView.image = image
        }
        
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

