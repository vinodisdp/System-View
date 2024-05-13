//
//  ViewController.swift
//  System View
//
//  Created by Dr. Vinod Kumar on 02/05/24.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, MFMailComposeViewControllerDelegate  {

    @IBOutlet weak var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func shareButtonPressed(_ sender: UIButton) {
        
        guard let image = imageView.image else { return}
        let activitycontroller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activitycontroller.popoverPresentationController?.sourceView = sender
        present(activitycontroller, animated: true, completion: nil)
    }
    
    
    @IBAction func safaributtonTapped(_ sender: UIButton) {
        
        if let url = URL(string: "https://www.apple.com" ){
            let safariViewController  = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func cameraButtonTapped(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        
        let alertController = UIAlertController(title: "Choose image source", message: nil, preferredStyle: .actionSheet)
        
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {ACTION in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {ACTION in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)})
            alertController.addAction(photoLibraryAction)
        }
       
        
      //  let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {ACTION in print("Camera is selected")})
        
      //  let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {ACTION in print("Phot library selected")})
      //  alertController.addAction(cameraAction)
     //   alertController.addAction(photoLibraryAction)
        
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
      guard let selectedImage = info[.originalImage] as? UIImage else {return}
      imageView.image = selectedImage
      dismiss(animated: true, completion: nil)
   }
   @IBAction func emailButtonTapped(_ sender: UIButton) {
        
        guard MFMailComposeViewController.canSendMail() else {
            print("Can not send mail")
            return
        }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["kumarvinod@galgotiasuniversity.edu.in"])
        mailComposer.setSubject("Testing Mail")
        mailComposer.setMessageBody("This mail is for my app", isHTML: false)
        if let image = imageView.image, let jpegData = image.jpegData(compressionQuality: 0.9){
            mailComposer.addAttachmentData(jpegData, mimeType: "image/jpeg", fileName: "myimage.jpg")
        }
        present(mailComposer, animated: true, completion: nil)
    }
    
}

