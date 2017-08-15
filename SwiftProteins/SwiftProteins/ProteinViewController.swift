//
//  ProteinViewController.swift
//  SwiftProteins
//
//  Created by Igor Chemencedji on 8/14/17.
//  Copyright © 2017 Igor Chemencedji. All rights reserved.
//

import UIKit
import SceneKit

class ProteinViewController: UIViewController {
    
    static var proteinName: String = ""
    @IBOutlet var proteinModel: SCNView!
    var proteinModels: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ProteinViewController.proteinName
        let url = URL(string: "https://files.rcsb.org/ligands/view/\(ProteinViewController.proteinName)_ideal.pdb")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data,
                let html = String(data: data, encoding: String.Encoding.utf8) {
                self.proteinModels.append(contentsOf: html.components(separatedBy: .newlines))
                for line in self.proteinModels{
                    let scene = line.components(separatedBy: .whitespaces)
                    print(scene)
                    if scene.contains("ATOM"){
                        //self.loadView()
                    } else if scene.contains("CONECT"){
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    /*override func loadView() {
        // create a scene view with an empty scene
        let sceneView = SCNView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let scene = SCNScene()
        sceneView.scene = scene
        
        // default lighting
        sceneView.autoenablesDefaultLighting = true
        
        // a camera
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        scene.rootNode.addChildNode(cameraNode)
        
        // a geometry object
        let box = SCNBox(width: 1, height: 4, length: 9, chamferRadius: 0)
        let boxNode = SCNNode(geometry: box)
        scene.rootNode.addChildNode(boxNode)
        
        // configure the geometry object
        box.firstMaterial?.diffuse.contents  = UIColor.red
        box.firstMaterial?.specular.contents = UIColor.white
        
        // set a rotation axis (no angle) to be able to
        // use a nicer keypath below and avoid needing
        // to wrap it in an NSValue
        boxNode.rotation = SCNVector4(x: 1, y: 1, z: 0.0, w: 0.0)
        
        // animate the rotation of the torus
        let spin = CABasicAnimation(keyPath: "rotation.w") // only animate the angle
        spin.toValue = 2.0*M_PI
        spin.duration = 10
        spin.repeatCount = HUGE // for infinity
        boxNode.addAnimation(spin, forKey: "spin around")
        view = sceneView // Set the view property to the sceneView created here.
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*func CPKcoloring(gem: SCNSphere, color: String) {
        
        switch color {
        case "H":
            gem.firstMaterial?.diffuse.contents = UIColor.white
        case "C":
            gem.firstMaterial?.diffuse.contents = UIColor.black
        case "N":
            gem.firstMaterial?.diffuse.contents = UIColor(red:0.00, green:0.14, blue:0.49, alpha:1.0)
        case "O":
            gem.firstMaterial?.diffuse.contents = UIColor.red
        case "F", "Cl":
            gem.firstMaterial?.diffuse.contents = UIColor.green
        case "Br":
            gem.firstMaterial?.diffuse.contents = UIColor(red:0.49, green:0.00, blue:0.00, alpha:1.0)
        case "I":
            gem.firstMaterial?.diffuse.contents = UIColor(red:0.37, green:0.00, blue:0.49, alpha:1.0)
        case "He", "Ne", "Ar", "Xe", "Kr":
            gem.firstMaterial?.diffuse.contents = UIColor(red:0.22, green:0.94, blue:0.99, alpha:1.0)
        case "P":
            gem.firstMaterial?.diffuse.contents = UIColor.orange
        case "S":
            gem.firstMaterial?.diffuse.contents = UIColor.yellow
        case "B":
            gem.firstMaterial?.diffuse.contents = UIColor(red:0.99, green:0.73, blue:0.51, alpha:1.0)
        case "Li", "Na", "K", "Rb", "Cs", "Fr":
            gem.firstMaterial?.diffuse.contents = UIColor.purple
        case "Be", "Mg", "Ca", "Sr", "Ba", "Ra":
            gem.firstMaterial?.diffuse.contents = UIColor(red:0.05, green:0.33, blue:0.02, alpha:1.0)
        case "Ti":
            gem.firstMaterial?.diffuse.contents = UIColor.gray
        case "Fe":
            gem.firstMaterial?.diffuse.contents = UIColor.orange
        default:
            gem.firstMaterial?.diffuse.contents = UIColor(red:1.00, green:0.00, blue:0.60, alpha:1.0)
        }
        
    }*/
}
