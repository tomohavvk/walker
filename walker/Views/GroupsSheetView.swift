//
//  GroupsSheetView.swift
//  walker
//
//  Created by IZ on 14.02.2024.
//

import SwiftUI

class GroupSheetModel : ObservableObject {
    @Published var searchingFor: String
    @Published var groupsToShow: [Group]
    
    
    init(searchingFor: String,  groupsToShow: [Group]) {
        self.searchingFor = searchingFor
        self.groupsToShow = groupsToShow
        }

}


struct GroupsSheetView: View {
    
    var results: [Group]
    
    
    private let geo: GeometryProxy
    private  let navView: NavigationBarView
    @ObservedObject  var groupSheetModel: GroupSheetModel
    
 
    init ( geo: GeometryProxy, navView: NavigationBarView, groupSheetModel: GroupSheetModel) {
      
        self.geo = geo
        self.navView = navView
        self.groupSheetModel = groupSheetModel
        
        print(groupSheetModel.searchingFor)
        if groupSheetModel.searchingFor.isEmpty {
       
            self.results =  groupSheetModel.groupsToShow
        } else {
            self.results  = groupSheetModel.groupsToShow.filter { $0.name.contains(groupSheetModel.searchingFor) }
        }

    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                GroupsListView(groupsToShow: results)
                    .searchable(text:  $groupSheetModel.searchingFor)
                    .navigationBarTitleDisplayMode(.inline)
            }
            
            .navigationBarItems(leading: navView)
        }
    }
    
    

}

#Preview {
    GeometryReader { geo in
        GroupsSheetView(geo: geo, navView: NavigationBarView(geo: geo, navModel: NavigationBarModel(currentTabOpened: "person")),
                        
                        groupSheetModel: GroupSheetModel(searchingFor: "", groupsToShow: groupsTesting)
        
        )
    }
    
}
