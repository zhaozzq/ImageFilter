//
//  ViewController.swift
//  ImageFilter
//
//  Created by zhaozq on 14-10-11.
//  Copyright (c) 2014年 zhaozq. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDataSource , UIPickerViewDelegate {
    
    var imageIndex:Int = 0
    let imageNumber:Int = 21
    var imagePicker:UIPickerView!
    var imageButton:UIButton!
    var pickerShows:Bool = false
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    //Create a place to render the filtered image
    let context = CIContext(options: nil)
    
    @IBAction func applyFilter(sender: AnyObject) {
        
        //Create an image to filter
        let inputImage = CIImage(image: photoImageView.image)
        
        
        //Create a random color to pass to a filter
        let random = Double (arc4random_uniform(314)) / 100
        println("random \(random)")
        let randomColor = [kCIInputAngleKey:random]
        
        //Apply a filter to the image
        let filteredImage = inputImage.imageByApplyingFilter("CIHueAdjust", withInputParameters: randomColor)
        
        //Render the filtered image
        let renderedImage = context.createCGImage(filteredImage, fromRect: filteredImage.extent())
        
        //Reflect the change back in the interface
        photoImageView.image = UIImage(CGImage: renderedImage);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let height =  self.navigationController?.toolbar.frame.size.height
        photoImageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height); // - 64 - height!
        
        var right = UIButton(frame: CGRectMake(0, 0, 30, 30))
        right.setTitle(">", forState: UIControlState.Normal)
        right.setTitleColor(UIColor(red: 0.118, green: 0.344, blue: 1.000, alpha: 1.000), forState: UIControlState.Normal)
        right.addTarget(self, action: "changeImageRight", forControlEvents: UIControlEvents.TouchUpInside)
        right.titleLabel?.font = UIFont.systemFontOfSize(25)
        var rightItem = UIBarButtonItem(customView: right)
        self.navigationItem.setRightBarButtonItem(rightItem, animated: true)
        
        var left = UIButton(frame: CGRectMake(0, 0, 30, 30))
        left.setTitle("<", forState: UIControlState.Normal)
        left.setTitleColor(UIColor(red: 0.118, green: 0.344, blue: 1.000, alpha: 1.000), forState: UIControlState.Normal)
        left.addTarget(self, action: "changeImageLeft", forControlEvents: UIControlEvents.TouchUpInside)
        left.titleLabel?.font = UIFont.systemFontOfSize(25)
        var leftItem = UIBarButtonItem(customView: left)
        self.navigationItem.setLeftBarButtonItem(leftItem, animated: true)
        
        imageButton = UIButton(frame: CGRectMake(0, 0, 80, 30))
        imageButton.setTitle("image 0", forState: UIControlState.Normal)
        imageButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        imageButton.addTarget(self, action: "imagePickerAction", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.titleView = imageButton;
        
        
    }
    func imagePickerAction()
    {
        
        println("imagePickerAction")
        
        var toolHeight:CGFloat =  44.0
        var height = self.view.frame.size.height
        var width = self.view.frame.size.width
        
        if pickerShows
        {
            let index = imagePicker.selectedRowInComponent(0)
            if imageIndex != index
            {
                photoImageView.image = UIImage(named: "\(index).jpg")
                imageIndex = index
                imageButton.setTitle("image \(imageIndex)", forState: UIControlState.Normal)
            }
            
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.imagePicker.frame = CGRectMake(0,  height, width, 162)
                }){ (finish) -> Void in
                    self.pickerShows = false
                    self.navigationController?.hidesBarsOnTap = true
            }

            return
        }
        
       
        if imagePicker == nil
        {
            imagePicker = UIPickerView(frame: CGRectMake(0,  height, width, 162))
            imagePicker.dataSource = self
            imagePicker.delegate = self
            imagePicker.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
            
//            done = UIButton(frame: CGRectMake(width - 50, 0, 50, 30))
//            done.setTitle("done", forState: UIControlState.Normal)
//            done.setTitleColor(UIColor(red: 0.118, green: 0.344, blue: 1.000, alpha: 1.000), forState: UIControlState.Normal)
//            done.addTarget(self, action: "changeImageDone", forControlEvents: UIControlEvents.TouchUpInside)
//            imagePicker.addSubview(done)
            
            
        }
    
        self.navigationController?.hidesBarsOnTap = false
        
        imagePicker.selectRow(imageIndex, inComponent: 0, animated: false)
        UIView .animateWithDuration(0.5, animations: { () -> Void in
            self.imagePicker.frame = CGRectMake(0, height - (162 + toolHeight), width, 162)
            }) { (finish) -> Void in
                self.pickerShows = true
                println("finish \(finish)")
        }
        self.view.addSubview(imagePicker)
        
    }
    func changeImageRight()
    {
        ++imageIndex
        imageIndex %= imageNumber
        
        photoImageView.image = UIImage(named: "\(imageIndex).jpg")
        imageButton.setTitle("image \(imageIndex)", forState: UIControlState.Normal)
        
    }
    func changeImageLeft()
    {
        imageIndex--
        if imageIndex < 0
        {
            imageIndex = imageNumber - 1
        }
        photoImageView.image = UIImage(named: "\(imageIndex).jpg")
        imageButton.setTitle("image \(imageIndex)", forState: UIControlState.Normal)
    }
    
    
    func setPickerShows(shows:Bool)
    {
        
    }
    
    //DataSource
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageNumber
    }
    //Delegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return "\(row)"
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //photoImageView.image = UIImage(named: "\(row).jpg")
        //imageIndex = row
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

