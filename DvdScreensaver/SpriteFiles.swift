//
//  SpriteFiles.swift
//  DvdScreensaver
//
//  Created by rsbj on 18/10/22.
//

import SpriteKit
import AVFoundation

public class PongScene: SKScene {
    
    var tocador: AVAudioPlayer?
    var ballNode: SKNode
    private var raqueteNode : SKNode
    private var nuvemNode: SKNode
    private var moveTransformBall = CGAffineTransform(translationX: 1, y: -1)
    private var moveTransformRaquete = CGAffineTransform(translationX: 0, y: 0)
    private var moveTransformNuvem = CGAffineTransform(translationX: 0, y: -0.1)
    
    public var ballPositionX: CGFloat = 0
    public var ballPositionY: CGFloat = 0
    
    
    public init(ballNode: SKNode, size: CGSize, raquete: SKNode, nuvem: SKNode) {
        self.ballNode = ballNode
        self.raqueteNode = raquete
        self.nuvemNode = nuvem
        super.init(size: size)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        addChild(ballNode)
        addChild(raqueteNode)
        addChild(nuvemNode)
        raqueteNode.position = CGPoint(x: self.frame.midX, y: CGFloat(Int(self.frame.minY)+45))
        nuvemNode.position = CGPoint(x: self.frame.midX, y: self.frame.maxY+(CGFloat(nuvemNode.frame.size.height)/2))
        ballNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
    }
    
    var speeed : Float = 1
    
    // Update is called once per frame
    public override func update(_ currentTime: TimeInterval) {
        speeed = speeed + 0.00005
        
        // Collect a reference frame for the node's current position
        let ballFrame = ballNode.calculateAccumulatedFrame()
        let frameRaquete = raqueteNode.calculateAccumulatedFrame()
        let frameNuvem = nuvemNode.calculateAccumulatedFrame()
        
        // Update the node's position by applying the transform
        ballNode.position = ballNode.position.applying(moveTransformBall)
        nuvemNode.position = nuvemNode.position.applying(moveTransformNuvem)
        raqueteNode.position = raqueteNode.position.applying(moveTransformRaquete)
        
        ballPositionX = ballFrame.midX-15 // Used to determinate de side were the music is coming from
        ballPositionY = ballFrame.midY-15 //Used to determinate the intensity of the music
        
        // Top bound
        if ballFrame.maxY >= self.frame.maxY+10 {
            moveTransformBall.ty = CGFloat(-speeed)
        }
        
        // Right bound
        if ballFrame.maxX >= self.frame.maxX+10 {
            moveTransformBall.tx = CGFloat(-speeed)
        }
        
        
        // Left bound
        if ballFrame.minX <= self.frame.minX-15 {
            moveTransformBall.tx = CGFloat(+speeed)
        }
        
        // Bottom bound
        if frameRaquete.maxY >= ballFrame.minY+15 && ballFrame.minX <= frameRaquete.maxX-15 && ballFrame.maxX >= frameRaquete.minX+15 && frameRaquete.minY <= ballFrame.maxY-35{
            moveTransformBall.ty = CGFloat(+speeed)
        }
        
        if frameNuvem.minY <= self.frame.minY+80{
            moveTransformNuvem.ty = 0
        }
        
        if let tocador = tocador, tocador.isPlaying {
            if ballPositionX/self.frame.maxX >= 0 {
                tocador.pan = Float((ballPositionX - self.frame.midX)/self.frame.midX) // -1 -> 1
                tocador.volume = Float(1 - (ballPositionY/(self.frame.height - 60))) // alto 0 -> baixo 1
                print(tocador.volume)
//                tocador.pan = 1 // esquerda
//                tocador.pan = -1 // direita
            }
//            tocador.pan += Float(ballPositionX/self.frame.maxX)
        }
        else {
            let urlString = Bundle.main.path(forResource: "soundtrack", ofType: "mp3")
            
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true,options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                tocador = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let tocador = tocador else {
                    return
                }
                
                tocador.play()
            }
            catch{
                print("Deu erro ae mané")
            }
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let frameRaquete = raqueteNode.calculateAccumulatedFrame()
            
            let location = touch.location(in: self)
            
            if frameRaquete.maxX <= self.frame.maxX && frameRaquete.minX >= self.frame.minX{
                raqueteNode.position.x = location.x
            }
            
            // Right bound
            if frameRaquete.maxX >= self.frame.maxX {
                raqueteNode.position.x = raqueteNode.position.x - 3
            }

            // Left bound
            if frameRaquete.minX <= self.frame.minX {
                raqueteNode.position.x = raqueteNode.position.x + 3
            }
            
        }
    }
}
