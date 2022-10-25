//
// SpriteFiles.swift
// DvdScreensaver
//
// Created by rsbj on 18/10/22.
//

import SpriteKit
import AVFoundation
import SwiftUI

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

public class PongScene: SKScene {
    
    var tocador: AVAudioPlayer?
    
    var ballNode: SKNode
    var raqueteNode : SKNode
    var nuvemNode: SKNode
    var score = SKLabelNode()
    
    var moveTransformBall = CGAffineTransform(translationX: 2, y: -2) // função para mover a bola
    var moveTransformNuvem = CGAffineTransform(translationX: 0, y: -0.3) // função para mover a nuvem
    
    public init(ballNode: SKNode, size: CGSize, raquete: SKNode, nuvem: SKNode) {
        self.ballNode = ballNode // pegando os dados da ContentView
        self.raqueteNode = raquete
        self.nuvemNode = nuvem
        super.init(size: size) // Definido o tamanho da Scene o tamanho dado
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        addChild(ballNode) // colocando os objetos na Scene
        addChild(raqueteNode)
        addChild(nuvemNode)
        addChild(score)
        
        ballNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY) // definindo a posição inicial
        raqueteNode.position = CGPoint(x: self.frame.midX, y: CGFloat(Int(self.frame.minY)+45))
        score.position = CGPoint(x: self.frame.midX, y: CGFloat(Int(self.frame.maxY)-70))
        nuvemNode.position = CGPoint(x: self.frame.midX, y: self.frame.maxY+(CGFloat(nuvemNode.frame.size.height)/2)) // nessa parte, na declaração do y, a gente tem que usar “CGFloat(nuvemNode.frame.size.height)/2” para corrigir, por a função “position(x:,y:)” sempre usa o midX e midY
        
        score.text = "0"
        
        
    }
    
    var ballPositionX: CGFloat = 0
    var ballPositionY: CGFloat = 0
    var speeed : Float = 2 // velocidade inicial da bola
    var primeiraSpeeed: Float = 0
    var scoreCount = 0
    
    // Update is called once per frame
    public override func update(_ currentTime: TimeInterval) {
        speeed = speeed + 0.0001
        
        // Collect a reference frame for the node’s current position
        let ballFrame = ballNode.calculateAccumulatedFrame()
        let frameRaquete = raqueteNode.calculateAccumulatedFrame()
        let frameNuvem = nuvemNode.calculateAccumulatedFrame()
        
        // Update the node’s position by applying the transform
        ballNode.position = ballNode.position.applying(moveTransformBall)
        nuvemNode.position = nuvemNode.position.applying(moveTransformNuvem)
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
        
        // Bottom bound -> raquete
        if frameRaquete.maxY >= ballFrame.minY+15 && ballFrame.minX <= frameRaquete.maxX-15 && ballFrame.maxX >= frameRaquete.minX+15 && frameRaquete.minY <= ballFrame.minY{
            
            if speeed > (primeiraSpeeed + 0.0003){
                primeiraSpeeed = speeed
                moveTransformBall.ty = CGFloat(+speeed)
                UIDevice.vibrate()
                
                scoreCount += 1
                score.text = String(scoreCount)
            }
            
        }
        
        if frameNuvem.minY <= self.frame.minY+80{
            moveTransformNuvem.ty = 0
        }
        
        if let tocador = tocador, tocador.isPlaying {
            if ballPositionX/self.frame.maxX >= 0 {
                tocador.pan = Float((ballPositionX - self.frame.midX)/self.frame.midX) // -1 -> 1
                tocador.volume = Float(1 - (ballPositionY/(self.frame.height - 60))) // alto 0 -> baixo 1
            }
        }
        else {
            let urlString = Bundle.main.path(forResource: "soundtrack", ofType: "mp3")// defining the song
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true,options: .notifyOthersOnDeactivation)
                guard let urlString = urlString else {
                    return
                }
                tocador = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                guard let tocador = tocador else { // unraping
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
            // Right bound safe
            if frameRaquete.maxX >= self.frame.maxX {
                raqueteNode.position.x = raqueteNode.position.x - 2.5
            }
            // Left bound safe
            if frameRaquete.minX <= self.frame.minX {
                raqueteNode.position.x = raqueteNode.position.x + 2.5
            }
        }
    }
}
