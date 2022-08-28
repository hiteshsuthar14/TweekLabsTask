//
//  Leaderboard-ViewModel.swift
//  TweekLabs
//
//  Created by Hitesh Suthar on 15/08/22.
//

import Foundation
import SwiftUI

extension LeaderboardView {
    
    class ViewModel: ObservableObject {
        
        let userId = 009
        
        @Published var searchTerm = ""
        
        @Published var activityData = Bundle.main.decode("data.json")
        
        @Published var sortedData = [Athlete]()
        
        @Published var showingSortSheet : Bool = false
        
        var currentFilter = SortingCategories.score.rawValue
        
        var searchedItems: [Athlete] {
            sortedData.filter {$0.name.localizedStandardContains(searchTerm)}
        }
        
        @Published var mycategory = SortingCategories.score
        
        func sortBy (category: SortingCategories) {
            
            switch category {
                case .score:
                    return sortByScore()
                
                case .runup:
                    return sortByRunup()
                    
                case .jump:
                    return sortByJump()
                
                case .backFootContact:
                    return sortByBackFootContact()
                
                case .frontFootContact:
                    return sortByFrontFootContact()
                
                case .release:
                    return sortByRelease()
            }
        }
        
    
        func sortByScore() {
            let sortedArray = activityData.athletes.sorted (by: { $0.score > $1.score })
            sortedData = sortedArray
            currentFilter = SortingCategories.score.rawValue
        }
        func sortByRunup() {
            let sortedArray = activityData.athletes.sorted (by: { $0.runup < $1.runup })
            sortedData = sortedArray
            currentFilter =  SortingCategories.runup.rawValue /*"Run-up*/
        }
        func sortByJump() {
            let sortedArray = activityData.athletes.sorted (by: { $0.jump > $1.jump })
            sortedData = sortedArray
            currentFilter = SortingCategories.jump.rawValue
        }
        func sortByBackFootContact() {
            let sortedArray = activityData.athletes.sorted (by: { $0.bfc > $1.bfc })
            sortedData = sortedArray
            currentFilter = SortingCategories.backFootContact.rawValue
        }
        func sortByFrontFootContact() {
            let sortedArray = activityData.athletes.sorted (by: { $0.ffc > $1.ffc })
            sortedData = sortedArray
            currentFilter = SortingCategories.frontFootContact.rawValue
        }
        func sortByRelease() {
            let sortedArray = activityData.athletes.sorted (by: { $0.release > $1.release })
            sortedData = sortedArray
            currentFilter = SortingCategories.release.rawValue
        }
        
        func autoScollPoint(point: ScrollViewProxy) {
            point.scrollTo(userId)
        }
        
        
        func showMedals(index: Int) -> Image? {
            
            guard index < 3 else {return nil}
            
            switch (index+1) {
            case 1: return Image("1")
            case 2: return Image("2")
            case 3: return Image("3")
            default: return nil
                
            }
        }
        
        func delayedSheetExit() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.showingSortSheet = false
            }
        }
    }
}

extension Bundle {
    func decode (_ file: String) -> ActivityData {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle")
        }
        guard let data = try? Data(contentsOf: url) else {
            fatalError("failed to load \(file) bundle")
        }
        let decoder = JSONDecoder()
        guard let loaded = try? decoder.decode(ActivityData.self, from: data) else {
             fatalError("Failed to decode \(file) from bundle")
        }
        return loaded
    }
}

enum SortingCategories : String, CaseIterable {
    case score = "Score"
    case runup = "Run-Up"
    case jump = "Jump"
    case backFootContact = "Back-Foot Contact"
    case frontFootContact = "Front-Foot Contact"
    case release = "Release"
}
