//
//  ProteinViewController.swift
//  SwiftProteins
//
//  Created by Igor Chemencedji on 8/14/17.
//  Copyright © 2017 Igor Chemencedji. All rights reserved.
//

import UIKit
import SceneKit
import SpriteKit

class ProteinViewController: UIViewController {
    
    static var proteinName: String = ""
    var AtomList:[SCNNode] = []
    
    @IBOutlet weak var elementLabel: UILabel!
    
    
    @IBOutlet weak var viewProtein: SCNView!
    var proteinModels: [String] = []
    
    
    func userDidTapShare() {
        let newImage:UIImage = self.viewProtein.snapshot()
        UIGraphicsEndImageContext()
        print(newImage)
        let imageToShare = [ newImage ]
        let avc = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        avc.popoverPresentationController?.sourceView = self.view
        self.present(avc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = ProteinViewController.proteinName
        let shareBar: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .action , target: self, action: #selector(ProteinViewController.userDidTapShare))
        self.navigationItem.rightBarButtonItem = shareBar
        let url = URL(string: "https://files.rcsb.org/ligands/view/\(ProteinViewController.proteinName)_ideal.pdb")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data,
                let html = String(data: data, encoding: String.Encoding.utf8) {
                self.proteinModels.append(contentsOf: html.components(separatedBy: .newlines))
//                self.viewProtein = SCNView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
                self.viewProtein = SCNView(frame: self.viewProtein.frame)
                self.viewProtein?.scene = SCNScene()
                self.viewProtein?.autoenablesDefaultLighting = true
                self.viewProtein?.allowsCameraControl = true
                self.viewProtein?.backgroundColor = UIColor.cyan
                let cameraNode = SCNNode()
                cameraNode.camera = SCNCamera()
                cameraNode.position = SCNVector3(x: 0, y: 0, z: 60)
                self.viewProtein?.scene?.rootNode.addChildNode(cameraNode)
                for line in self.proteinModels{
                    var sceneP = line.components(separatedBy: .whitespaces)
                    sceneP = sceneP.filter { $0 != ""}
                    //print(sceneP)
                    if sceneP.contains("ATOM"){
                        let shape = SCNSphere(radius: 0.3)
                        self.CPKcoloring(gem: shape, color: sceneP[11])
                        let shapeNode = SCNNode(geometry: shape)
                        shapeNode.position = SCNVector3(x: Float(sceneP[6])!, y: Float(sceneP[7])!, z: Float(sceneP[8])!)
                        self.viewProtein?.scene?.rootNode.addChildNode(shapeNode)
                        self.AtomList.append(shapeNode)
                        self.view = self.viewProtein
                    } else if sceneP.contains("CONECT"){
                        let from = Int(sceneP[1])
                        let to = sceneP[2..<sceneP.count]
                        for elem in to {
                            let line = self.drawLineNode(nodeA: self.AtomList[from! - 1], nodeB: self.AtomList[Int(elem)! - 1])
                            self.viewProtein?.scene?.rootNode.addChildNode(line)
                        }
                    }
                    self.elementLabel.text = "Selected element:"
                }
            }
        }
        task.resume()
    }
    
    
    func drawLineNode(nodeA: SCNNode, nodeB: SCNNode) -> SCNNode {
        let positions: [Float32] = [nodeA.position.x, nodeA.position.y, nodeA.position.z, nodeB.position.x, nodeB.position.y, nodeB.position.z]
        let positionData = NSData(bytes: positions, length: MemoryLayout<Float32>.size*positions.count)
        let indices: [Int32] = [0, 1]
        let indexData = NSData(bytes: indices, length: MemoryLayout<Int32>.size * indices.count)
        let source = SCNGeometrySource(data: positionData as Data, semantic: SCNGeometrySource.Semantic.vertex, vectorCount: indices.count, usesFloatComponents: true, componentsPerVector: 3, bytesPerComponent: MemoryLayout<Float32>.size, dataOffset: 0, dataStride: MemoryLayout<Float32>.size * 3)
        let element = SCNGeometryElement(data: indexData as Data, primitiveType: SCNGeometryPrimitiveType.line, primitiveCount: indices.count, bytesPerIndex: MemoryLayout<Int32>.size)
        
        let line = SCNGeometry(sources: [source], elements: [element])
        line.firstMaterial?.diffuse.contents = UIColor.black
        return SCNNode(geometry: line)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func CPKcoloring(gem: SCNSphere, color: String) {
        
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
        
    }
}
