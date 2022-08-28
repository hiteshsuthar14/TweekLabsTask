//
//  LeaderboardView.swift
//  TweekLabs
//
//  Created by Hitesh Suthar on 15/08/22.
//

import SwiftUI

struct LeaderboardView: View {
    
    @StateObject var vm = ViewModel()
    
    @State private var showSearchBox: Bool = false
    
    @State private var jumpToUser = false
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isSearchFocused: Bool
    
    var body: some View {
        ScrollViewReader { point in
            ZStack {
                GeometryReader { geo in
                    Rectangle().fill(Color("Primary"))
                        .frame( height: geo.size.height * 0.35)
                }
                .ignoresSafeArea()
    
                ZStack {
                    
                    VStack(spacing: 0) {
                        HStack(alignment: .center) {
                            
                            Image("ic-back")
                                .frame(width: 12.12, height: 20)
                                .padding(.leading, 18)
                            
                            Text("LeaderBoard")
                                .padding(.leading, 31)
                                .padding(.top, 0)
                                .foregroundColor(.white)
                                .font(.semibold_24px)
                            
                            Spacer()
                            
                            Button{ showSearchBox = true } label: {
                                Image("ic-Mglass")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing, 24)
                            }
                        }.padding(.top, 18)
                        
                        HStack {
                            Text(vm.activityData.organisation)
                                .font(.regular_14px)
                                .padding(EdgeInsets(top: 48, leading: 20, bottom: 18, trailing: 0))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        ScrollView(showsIndicators: false) {
                            
                            VStack {
                                
                                LazyVStack(spacing: 12) {
                                    
                                    ForEach(Array(vm.sortedData.enumerated()) , id: \.element) { index, athlete in
                                        
                                        HStack(spacing: 0) {
                                            
                                            ZStack {
                                                vm.showMedals(index: index)
                                                Text(index+1, format: .number)
                                                    .font(.semibold_14px)
                                                    .foregroundColor(Color("Black 2"))
                                            }
                                            .frame(width: 27, height: 27)
                                            .padding(.leading, 14)
                                            
                                            
                                            Image("\(athlete.id)")
                                                .resizable()
                                                .frame(width: 43, height: 43)
                                                .padding(.leading, 13)
                                            
                                            Text(athlete.name)
                                                .font(.medium_16px)
                                                .padding(.leading, 12)
                                                .foregroundColor(Color("Black 1"))
                                            
                                            Spacer()
                                            
                                            Text(athlete.score, format: .number)
                                                .font(.medium_18px)
                                                .frame(width: 22, height: 24)
                                                .padding(.trailing, 18)
                                                .foregroundColor(Color("Black 1"))
                                        }
                                        .id(Int(athlete.id))
                                        .frame(maxWidth: .infinity, minHeight: 72)
                                        .background(.white)
                                        .cornerRadius(16)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 16).stroke(vm.userId == Int(athlete.id) ? Color("Primary") : .white.opacity(0)))
                                        .padding(.horizontal, 18)
                                        .shadow(color: Color("athleteBoxShadow"), radius: 12, x: 0, y: 4)
                                    }
                                }
                            }
                        }
                        .onAppear(perform: vm.sortByScore)
                        
                        .sheet(isPresented: $vm.showingSortSheet) {

                            VStack(alignment: .leading, spacing: 0) {
                                
                                Text("Sort By")
                                    .font(.semibold_18px)
                                    .padding(.bottom, 19)
                                
                                VStack(spacing: 0) {
                                    
                                    ForEach(SortingCategories.allCases, id: \.self) { category in
                                        
                                        HStack(spacing: 0) {
                                            Image (systemName:  category.rawValue == vm.currentFilter ? "circle.inset.filled" : "circle")
                                                .frame(width: 24, height: 24)
                                            Button { vm.sortBy(category: category)
                                                vm.delayedSheetExit() } label: {
                                                    Text(category.rawValue)
                                                        .font(.medium_16px)
                                                        .foregroundColor(Color("Black 1"))
                                                        .padding(.leading, 14)
                                                }
                                            Spacer()
                                        }
                                    }
                                }
                            }.padding(.leading, 24)
                        }
                        
                        HStack(spacing: 0) {
                            Image("ic-arrow")
                                .resizable()
                                .frame(width: 19, height: 16)
                                .padding(.trailing, 4)
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Sort by")
                                    .font(.semibold_14px)
                                Text(vm.currentFilter)
                                    .font(.medium_8px)
                                
                            }.padding(.leading, 4)
                        }
                        .frame(height: 48)
                        .shadow(color: Color("athleteBoxShadow"), radius: 12, x: 0, y: 4)
                        .foregroundColor(Color("Black 1"))
                        .onTapGesture() {
                            vm.showingSortSheet = true
                        }
                        .background(.white)
                    }
                }
                Spacer()
                
                Button(action: { point.scrollTo(vm.userId, anchor: .center) }, label: {
                    Text("My Score")})
                .frame(width: 130, height: 42)
                .background(Color("Primary"))
                .cornerRadius(32)
                .font(.semibold_14px)
                .foregroundColor(Color.white)
                .position(x: UIScreen.screenWidth/2, y: UIScreen.screenHeight*0.75)
            }
            if showSearchBox {
                ZStack {
                    Rectangle()
                        .fill(Color("Black 1"))
                        .opacity(0.62)
                        .blur(radius: 2, opaque: false)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showSearchBox = false}
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            TextField("Search athele", text: $vm.searchTerm)
                                .padding(.leading, 18)
                            
                            Image("ic-Mglass-gray")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 18))
                        }
                        .font(.regular_14px)
                        .frame(height: 49)
                        .background(.white)
                        .cornerRadius(12)
                        .foregroundColor(Color("Black 3"))
                        .padding(EdgeInsets(top: 9, leading: 18, bottom: 18, trailing: 18))
                        
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(Array(vm.searchedItems) , id: \.self) {  athlete in
                                    
                                    HStack(spacing: 0) {
                                        
                                        Image("\(athlete.id)")
                                            .resizable()
                                            .frame(width: 43, height: 43)
                                            .padding(.leading, 18)
                                        
                                        Text(athlete.name)
                                            .font(.medium_16px)
                                            .padding(.leading, 12)
                                        
                                        Spacer()
                                        
                                        Text(athlete.score, format: .number)
                                            .font(.medium_18px)
                                            .frame(width: 22, height: 24)
                                            .padding(.trailing, 18)
                                    }
                                    .frame(maxWidth: .infinity, minHeight: 72)
                                    .background(.white)
                                    .cornerRadius(16)
                                    .padding(.horizontal, 18)
                                    .shadow(color: Color("athleteBoxShadow"), radius: 12, x: 0, y: 4)
                                }
                            }
                        }
                        .onTapGesture { showSearchBox = false}
                        Spacer()
                    }
                }
            }
        }
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}
