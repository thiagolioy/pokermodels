//
//  PaymentDistribuition.swift
//  PokerModels
//
//  Created by Thiago Lioy on 16/02/20.
//  Copyright © 2020 Thiago Lioy. All rights reserved.
//

import Foundation

struct Transaction {
    let from: Player
    let to: Player
    let amount: Double
}

extension Transaction: Equatable {}

func ==(lhs: Transaction, rhs: Transaction) -> Bool {
    return lhs.from == rhs.from &&
        lhs.to == rhs.to &&
        lhs.amount == rhs.amount
}

struct PlayerPerformance {
    let player: Player
    let performance: Double
}

struct PaymentDistribuition {
    
    func calculate(for event: Event) -> [Transaction] {
        
        let performances: [PlayerPerformance] = event.players.map {
            PlayerPerformance(player: $0.player, performance: event.profit(for: $0.player))
        }
        
        let receivers = performances.filter({$0.performance > 0})
        let payers = performances.filter({$0.performance < 0})
           
        return transactions(from: payers, to: receivers)
    }
    
}

fileprivate extension PaymentDistribuition {
    
    func transactions(from payers: [PlayerPerformance], to receivers: [PlayerPerformance]) -> [Transaction] {
           
           //Make sure the collections are sorted
           let payers = payers.sorted(by: {$0.performance < $1.performance})
           let receivers = receivers.sorted(by: {$0.performance > $1.performance})
           
           var transactions: [Transaction] = []
           
           // Settled Collection will be used to remove people
           // That already got pay from the inner loop
           var settled: [Player] = []
           
           for payer in payers {
               
               var payerFunds = abs(payer.performance)
               
               // Remove people that already got paid from the list
               let stillMissingPayment = receivers.filter{ !settled.contains($0.player) }
                                                  .sorted(by: {$0.performance > $1.performance})
               
               
               for receiver in stillMissingPayment {
                   
                   let alreadyPayed = transactions.filter({$0.to == receiver.player})
                                                  .map({$0.amount})
                                                  .reduce(0, +)
                   let stillNeedsToReceive = abs(receiver.performance) - alreadyPayed
                   
                   if payerFunds >= stillNeedsToReceive {
                   
                       payerFunds -= stillNeedsToReceive
                       settled.append(receiver.player)
                       let t = Transaction(
                           from: payer.player,
                           to: receiver.player,
                           amount: stillNeedsToReceive
                       )
                       transactions.append(t)
                       
                   } else {
                       
                       let t = Transaction(
                           from: payer.player,
                           to: receiver.player,
                           amount: abs(payerFunds)
                       )
                       transactions.append(t)
                       
                       payerFunds = 0
                       break
                   }
                   
               }
               
               
           }
           
           return transactions
       }

}
