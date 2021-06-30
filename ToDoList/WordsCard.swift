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
    @IBOutlet weak var cardBoundsView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var wordTextField: UITextField!
    @IBOutlet weak var translationTextField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteAndSaveControl: UISegmentedControl!
    
    var addWordDelegate: AddNewWordDelegate!
    
    // MARK: - GlobalConnectionProperties
    var color = UIColor.black
    
    //EditingProperties
    var editedtext: String?
    var editedTranlation: String?
    var editedImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: - ElementInitialisation
        //DataPass
       
        if editedtext != nil || editedTranlation != nil {
            wordTextField.text = editedtext
            translationTextField.text = editedTranlation
            imageView.image = editedImage
        }
        
    //MARK: - ImageUserInterractionSettings
        
        //ImageViewUserInterection
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
        imageView.addGestureRecognizer(tapGesture)
            // make sure imageView can be interacted with by user
        imageView.isUserInteractionEnabled = true
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        wordTextField.delegate = self
        translationTextField.delegate = self
        //translationTextField.isHidden = true
        //deleteAndSaveControl.selectedSegmentIndex = 0
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //MARK: - UIElementsDesign
            
            //ViewDesign
            backGroundView.backgroundColor = color
            backGroundView.alpha = 1
            textFieldDesign(element:translationTextField)
            textFieldDesign(element:wordTextField)
            imageViewDesign(element: imageView)
            buttonDesign(element: delete)
            buttonDesign(element: saveButton)
            viewDesing(element: cardBoundsView )
        deleteAndSaveControl.isHidden = true
        //deleteAndSaveControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        
        
        
           
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
    
    //Temporaly is Hidden
    /*@IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
            //wordTextField.isHidden = true
            translationTextField.isHidden = true
        } else {
            //wordTextField.isHidden = false
            translationTextField.isHidden = false
        }
    }
    */
    @IBAction func deleteAction(_ sender: Any) {
        guard editedtext != nil else {return}
        addWordDelegate.deleteItem(name: editedtext!)
        navigationController?.popViewController(animated:true)
    }
    
    @IBAction func backTotableViewButton(_ sender: Any) {
        
        if wordTextField.text != nil || translationTextField.text != nil || imageView.image != nil {
            
            if let delegate = addWordDelegate {
                print("DelegateIsInitiated")
                print("Text, translation and image are existing")
                
                if editedtext != nil || editedTranlation != nil || editedImage != nil {
                    
                    let data = editedImage?.pngData()
                    let newData = imageView.image!.pngData()
                    
                    if !delegate.isItemExist(item: wordTextField.text!, translation: translationTextField.text!, image: newData!) {
                        print("CurrentItemDoesn'tExist")
                        
                        delegate.shouldReplace(item: editedtext!, withItem: wordTextField.text!)
                        
                        delegate.translationReplace(translation: editedTranlation!, with: translationTextField.text!)
                        
                        delegate.imageReplace(image: data!, newImage: newData!)
                        
                        navigationController?.popViewController(animated: true)
                      } else {
                        print("CurrentItemExist")
                        
                        let alert = UIAlertController(title: "NoItem", message: "", preferredStyle: .alert)
                          alert.addAction(UIAlertAction(title: "Cancel", style:.default, handler: nil))
                          present(alert, animated: true, completion: nil)
                        
                      }
                    
                } else {
                    
                    let word = wordTextField.text
                    let translation = translationTextField.text
                    //var image = imageView.image
                    var data: Data?
                    if imageView.image != nil {
                        let image = imageView.image
                        data = image?.pngData()
                    } else {
                         let image = UIImage(named: "circlePlus")
                        data = image?.pngData()
                    }
                    
                
                    if !delegate.isItemExist(item: word!, translation: translation!, image: data!) {
                       
                        delegate.addWord(word: word!, translation: translation!, image: data!)
                        
                        navigationController?.popViewController(animated: true)
                    } else {
                        
                        let alert = UIAlertController(title: "CurrentItemAlreadyExist", message: "", preferredStyle: .alert)
                          alert.addAction(UIAlertAction(title: "Cancel", style:.default, handler: nil))
                          present(alert, animated: true, completion: nil)
                    }
                    
                    
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

