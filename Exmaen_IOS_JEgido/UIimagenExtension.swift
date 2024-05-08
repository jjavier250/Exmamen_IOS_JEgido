//
//  UIimagenExtension.swift
//  Exmaen_IOS_JEgido
//
//  Created by Mañanas on 8/5/24.
//

import Foundation
import UIKit

extension UIImageView{
    func loadFrom(url:URL){
        DispatchQueue.global().async {[weak self] in
            if let data=try? Data(contentsOf:url){
                if let image=UIImage(data:data){
                    DispatchQueue.main.async{
                        self?.image=image
                    }
                }
            }
            
        }
    }
    
    func loadFrom(url:String){
        self.loadFrom(url: URL(string: url)!)
    }
}
