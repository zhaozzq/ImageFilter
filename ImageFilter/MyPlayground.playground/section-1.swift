// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var arr = []

var imageNameArr = [String]()
//var imageNameArr:Array<String> = []

for i in 0..<7
{
    var imageName = "testimage\(i)"
    imageNameArr.append(imageName)
}
imageNameArr


//let context = CIContext(options: nil)
////Create an image to filter
//var image = UIImage(named: "1.jpg")
//let inputImage = CIImage(image: image)
//
//
////Create a random color to pass to a filter
//let random = Double (arc4random_uniform(314)) / 100
//println("random \(random)")
//let randomColor = [kCIInputAngleKey:random]
//
////Apply a filter to the image
//let filteredImage = inputImage.imageByApplyingFilter("CIHueAdjust", withInputParameters: randomColor)
//
////Render the filtered image
//let renderedImage = context.createCGImage(filteredImage, fromRect: filteredImage.extent())
