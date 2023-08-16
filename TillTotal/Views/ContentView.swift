//
//  ContentView.swift
//  TillTotal
//
//  Created by Samuel Kreyenbühl on 03.08.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var coinTypes: [CoinTypeEntity] = []
    
    init() {
        do {
            let all = try CoinTypeEntityReopsitory(container: CoreDataManager.instance.container).getAll()
            self._coinTypes = State(wrappedValue: all)
            printValues()
        } catch {
            print("Error loading CoinTypes: \(error)")
        }
    }
    
    
    func printValues(){
        print("Number of fetched entities: \(coinTypes.count)")
        for coinType in coinTypes {
            print("Entity name: \(coinType.name ?? "No name was set")")
        }
    }
    var body: some View {
        if coinTypes.first != nil {
            CoinTypeView(vm: CoinTypeViewModel(coinTypeEntity: coinTypes.last!))
        } else {
            Text("No CoinType defined yet.")
        }
        
        Spacer()
        
        Button {
            coinTypes.append(CoinDataLoader.initCoinType(id: Int64(coinTypes.count), icon: "dollarsign.circle", isOther: false, name: "Münzen",
                                                         coins: [
                                                            CoinDataLoader.initCoin(value: 1.3),
                                                            CoinDataLoader.initCoin(value: 2),
                                                            CoinDataLoader.initCoin(value: 3),
                                                            CoinDataLoader.initCoin(value: 4),
                                                            CoinDataLoader.initCoin(value: 5.4),
                                                            CoinDataLoader.initCoin(value: 6),
                                                            CoinDataLoader.initCoin(value: 7.6),
                                                            CoinDataLoader.initCoin(value: 809090)
                                                         ]))
        } label: {
            Image(systemName: "plus.circle")
                .font(.largeTitle)
        }
    }
    func save() {
        CoreDataManager.instance.saveData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
