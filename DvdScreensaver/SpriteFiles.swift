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
    
    @Binding var scoreBound: Int
    @Binding var shouldShow: Bool
    
    var ballNode: SKNode
    var raqueteNode : SKNode
    var nuvemNode1: SKNode
    var nuvemNode2: SKNode
    var nuvemNode3: SKNode
    
    var moveTransformBall = CGAffineTransform(translationX: 2, y: -2) // função para mover a bola
    var moveTransformNuvem = CGAffineTransform(translationX: 4, y: -0.4) // função para mover a nuvem
    var moveTransformNuvem2 = CGAffineTransform(translationX: -4, y: -0.4)
    var moveTransformNuvem3 = CGAffineTransform(translationX: 4, y: -0.4)
    
    public init(ballNode: SKNode, size: CGSize, raquete: SKNode, nuvem: SKNode, nuvem2: SKNode, nuvem3: SKNode, score: Binding<Int>, deveMostrar: Binding<Bool>) {
        self.ballNode = ballNode // pegando os dados da ContentView
        self.raqueteNode = raquete
        self.nuvemNode1 = nuvem
        self.nuvemNode2 = nuvem2
        self.nuvemNode3 = nuvem3
        _scoreBound = score
        _shouldShow = deveMostrar
        super.init(size: size) // Definido o tamanho da Scene o tamanho dado
        setup()
    }
    
    
    private func setup() {
        addChild(ballNode) // colocando os objetos na Scene
        addChild(raqueteNode)
        addChild(nuvemNode3)
        addChild(nuvemNode2)
        addChild(nuvemNode1)
        
        ballNode.position = CGPoint(x: self.frame.midX, y: self.frame.midY) // definindo a posição inicial
        raqueteNode.position = CGPoint(x: self.frame.midX, y: CGFloat(Int(self.frame.minY)+45))
        
        nuvemNode1.position = CGPoint(x: self.frame.midX, y: self.frame.maxY+(CGFloat(nuvemNode1.frame.size.height)/2)+10) // nessa parte, na declaração do y, a gente tem que usar “CGFloat(nuvemNode.frame.size.height)/2” para corrigir, por a função “position(x:,y:)” sempre usa o midX e midY
        nuvemNode2.position = CGPoint(x: self.frame.midX, y: self.frame.maxY+(CGFloat(nuvemNode2.frame.size.height)/2))
        nuvemNode3.position = CGPoint(x: self.frame.midX+10, y: self.frame.maxY+(CGFloat(nuvemNode2.frame.size.height)/2)-2)
    }
    
    var ballPositionX: CGFloat = 0
    var ballPositionY: CGFloat = 0
    var speeed : Float = 2 // velocidade inicial da bola
    var primeiraSpeeed: Float = 0
    var scoreCount = 0
    
    // Update is called once per frame
    fileprivate func didLose(_ ballFrame: CGRect) {
        tocador?.stop()
        moveTransformBall.tx = 0
        moveTransformBall.ty = 0
        moveTransformNuvem.ty = 0
        moveTransformNuvem2.ty = 0
        moveTransformNuvem3.ty = 0
        //            nuvemNode1.position = CGPoint(x: self.frame.midX, y: self.frame.maxY + frameNuvem1.size.height/2)
        nuvemNode1.isHidden = true
        //            nuvemNode2.position = CGPoint(x: self.frame.midX, y: self.frame.maxY + frameNuvem2.size.height/2)
        nuvemNode2.isHidden = true
        //            nuvemNode3.position = CGPoint(x: self.frame.midX, y: self.frame.maxY + frameNuvem3.size.height/2)
        nuvemNode3.isHidden = true
        self.backgroundColor = .red
        
        
        
        //            raqueteNode.position = CGPoint(x: self.frame.midX, y: self.frame.maxY + frameNuvem1.size.height/2)
        raqueteNode.isHidden = true
        shouldShow = true
        
    }
    
    public override func update(_ currentTime: TimeInterval) {
        speeed = speeed + 0.0001
        
        // Collect a reference frame for the node’s current position
        let ballFrame = ballNode.calculateAccumulatedFrame()
        let frameRaquete = raqueteNode.calculateAccumulatedFrame()
        let frameNuvem1 = nuvemNode1.calculateAccumulatedFrame()
        let frameNuvem2 = nuvemNode2.calculateAccumulatedFrame()
        let frameNuvem3 = nuvemNode3.calculateAccumulatedFrame()
        
        // Update the node’s position by applying the transform
        ballNode.position = ballNode.position.applying(moveTransformBall)
        nuvemNode1.position = nuvemNode1.position.applying(moveTransformNuvem)
        nuvemNode2.position = nuvemNode2.position.applying(moveTransformNuvem2)
        nuvemNode3.position = nuvemNode3.position.applying(moveTransformNuvem3)
        
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
            let generator = UINotificationFeedbackGenerator() // Generator fot the vibration
            // Raquete
            if frameRaquete.maxY >= ballFrame.minY+15 && ballFrame.minX <= frameRaquete.maxX-15 && ballFrame.maxX >= frameRaquete.minX+15 && frameRaquete.minY <= ballFrame.midY && moveTransformBall.tx != 0
            {
                
                if speeed > (primeiraSpeeed + 0.001) {
                    primeiraSpeeed = speeed
                    moveTransformBall.ty = CGFloat(+speeed)
                    UIDevice.vibrate()
                    
                    generator.notificationOccurred(.success)
                    UIDevice.vibrate()
                    
                    scoreBound += 1
                }
            }
        }
        
        //Se a bola sai da tela
        if ballFrame.maxY <= self.frame.minY && moveTransformBall.tx != 0 {
            didLose(ballFrame)

        }
        
        if frameNuvem1.minY <= self.frame.minY+80{
            moveTransformNuvem.ty = 0
        }
        if frameNuvem1.midX >= self.frame.maxX{
            moveTransformNuvem.tx = -4
        }
        if frameNuvem1.midX <= self.frame.minX{
            moveTransformNuvem.tx = 4
        }
        if frameNuvem2.minY <= self.frame.minY+80{
            moveTransformNuvem2.ty = 0
        }
        if frameNuvem2.midX >= self.frame.maxX{
            moveTransformNuvem2.tx = -4
        }
        if frameNuvem2.midX <= self.frame.minX{
            moveTransformNuvem2.tx = 4
        }
        if frameNuvem3.minY <= self.frame.minY+80{
            moveTransformNuvem3.ty = 0
        }
        if frameNuvem3.midX >= self.frame.maxX{
            moveTransformNuvem3.tx = -6
        }
        if frameNuvem3.midX <= self.frame.minX{
            moveTransformNuvem3.tx = 6
        }
        
        // Audio System
        if let tocador = tocador, tocador.isPlaying && moveTransformBall.tx != 0 {
            if ballPositionX/self.frame.maxX >= 0 {
                tocador.pan = Float((ballPositionX - self.frame.midX)/self.frame.midX) // -1 -> 1
                tocador.volume = Float(1 - (ballPositionY/(self.frame.height - 60))) // alto 0 -> baixo 1
            }
        }
        
        else if moveTransformBall.tx != 0{
            let urlString = Bundle.main.path(forResource: "soundtrack", ofType: "mp3")// defining the song
            do{
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true,options: .notifyOthersOnDeactivation)
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: .duckOthers) // Makes audio play in silent mode
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
                print("Deu erro ae mané: \(error.localizedDescription)")
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
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

