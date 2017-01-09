//
//  DetailViewController.swift
//  Homepwner
//
//  Created by borko on 1/7/17.
//  Copyright © 2017 BorkoTomic. All rights reserved.
//

import UIKit

class DetailViewController : UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var item: Item!
        {
        didSet{
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!

    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func takePicture(_ sender: UIBarButtonItem)
    {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }
        else
        {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = true
        let overlayView = UIImageView(frame: imagePicker.view.frame)
        overlayView.image = #imageLiteral(resourceName: "placeholderImage")
        overlayView.alpha = 0.5
        imagePicker.cameraOverlayView = overlayView
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func deletePicture(_ sender: UIBarButtonItem) {
        
        if(nil != imageStore.imageForKey(key: item.itemKey)){
            imageStore.deleteImageForKey(key: item.itemKey)
        }
        
        imageView.image = #imageLiteral(resourceName: "placeholderImage")
    }
    let numberFormatter: NumberFormatter = {
    
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: item.valueInDollars as NSNumber)
        
        dateLabel.text = dateFormatter.string(from: item.dateCreated as Date)
        
        //Grab the key and display the image if there is asociated image for that key
        
        let tmpImage = imageStore.imageForKey(key: item.itemKey)
        
        if(nil != tmpImage)
        {
            imageView.image = tmpImage
        }
        else
        {
            imageView.image = #imageLiteral(resourceName: "placeholderImage")
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        //Save changed values to a model
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText)
        {
            item.valueInDollars = value.intValue
        }
        else
        {
            item.valueInDollars = 0
        }
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "ChangeDate" == segue.identifier
        {
                let datePickerViewController = segue.destination as! DateChangerViewController
                datePickerViewController.item = self.item
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        //Getting an image from UIImagePicker
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        //Setting the image in the image store for the itemKey of an item
        imageStore.setImage(image: image, forKey: item.itemKey)
        
        //Setting the image of the imageVIew to be an image returned from UIImagePIcker
        imageView.image = image
        
        // Dissmiss the UIImagePicker view
        dismiss(animated: true, completion: nil)
    }
    
}
