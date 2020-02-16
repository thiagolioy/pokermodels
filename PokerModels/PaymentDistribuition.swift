//
//  PaymentDistribuition.swift
//  PokerModels
//
//  Created by Thiago Lioy on 16/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

struct Transfer {
    let from: Player
    let to: Player
    let amount: Double
}

struct PlayerPerformance {
    let player: Player
    let performance: Double
}

struct PaymentDistribuition {
    
    func calculate(for event: Event) -> [Transfer] {
        
        let performances: [PlayerPerformance] = event.players.map {
            PlayerPerformance(player: $0.player, performance: event.profit(for: $0.player))
        }
        
        let profitablePlayers = performances.filter({$0.performance > 0})
            .sorted(by: {$0.performance > $1.performance})
        let payers = performances.filter({$0.performance < 0})
            .sorted(by: {$0.performance < $1.performance})
        
        var transfers: [Transfer] = []
        

        var settled: [Player] = []
        for payer in payers {
            
            var payerFunds = abs(payer.performance)
            
            while payerFunds != 0 {
                let stillMissingPayment = profitablePlayers.filter{ !settled.contains($0.player) }
                    .sorted(by: {$0.performance > $1.performance})
                for profitablePlayer in stillMissingPayment {
                    
                    if payerFunds >= profitablePlayer.performance {
                        
                        print("Player: \(payer.player.name) should pay: \(abs(profitablePlayer.performance)) to: \(profitablePlayer.player.name)")
                        
                        payerFunds -= abs(profitablePlayer.performance)
                        settled.append(profitablePlayer.player)
                        let t = Transfer(
                            from: payer.player,
                            to: profitablePlayer.player,
                            amount: abs(profitablePlayer.performance)
                        )
                        transfers.append(t)
                        
                    } else {
                        
                        print("Player: \(payer.player.name) should pay: \(payerFunds) to: \(profitablePlayer.player.name)")
                        
                        payerFunds = 0
                        let t = Transfer(
                            from: payer.player,
                            to: profitablePlayer.player,
                            amount: abs(payer.performance)
                        )
                        
                        let alreadyPayed = transfers.filter({$0.to == profitablePlayer.player})
                            .map({$0.amount})
                            .reduce(0, +)
                        
                        transfers.append(t)
                        
                        if alreadyPayed + t.amount == profitablePlayer.performance {
                            settled.append(profitablePlayer.player)
                        }
                        
                        //Should Break. No more funds to pay
                        break
                    }
                 
                }
                
                
            }
            
            
        }
        
        return transfers
    }
    
    
}
