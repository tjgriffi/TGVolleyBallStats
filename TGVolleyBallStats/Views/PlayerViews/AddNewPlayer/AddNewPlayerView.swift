//
//  AddNewPlayer.swift
//  TGVolleyBallStats
//
//  Created by Terrance Griffith on 4/2/26.
//

import SwiftUI

struct AddNewPlayerView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State var addNewPlayerVM: AddNewPlayerVM
    @State private var submitTask: Task<Void, Never>?
    @Binding var shouldViewBeDismissed: Bool
    
    
    var body: some View {
        Group {
            
            
            switch addNewPlayerVM.state {
            case .initial:
                VStack {
                    Text("Add a New Player")
                        .font(.title2)
                    
                    TextField("Please Enter a Name", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            // Cancel the previous task
                            submitTask?.cancel()
                            
                            // Start the new task
                            submitTask = Task {
                                await addNewPlayerVM.addNewPlayer(with: name)
                            }
                        }
                    
                    Button(action: {
                        // Cancel the previous task
                        submitTask?.cancel()
                        
                        // Start the new task
                        submitTask = Task {
                            await addNewPlayerVM.addNewPlayer(with: name)
                        }
                    }, label: {
                        Text("Submit")
                    })
                }
            case .loading:
                ProgressView()
                Text("Loading...")
            case .loaded:
                VStack {
                    Text("Player \(name) was successfully added!!")
                    Button {
                        shouldViewBeDismissed.toggle()
                        dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            case .error(let string):
                VStack {
                    Text("Something went wrong please try again")
                    Button {
                        addNewPlayerVM.resetState()
                    } label: {
                        Text("Try again")
                    }
                    .buttonStyle(.borderedProminent)
                    
                }
            }
        }
//        .frame(width: 300, height: 200)
    }
}

#Preview {
    NavigationStack{
        AddNewPlayerView(
            addNewPlayerVM: AddNewPlayerVM(
                playerRepository: CDPlayerRepository(
                    context: StorageManager.preview.container.viewContext,
                    cache: PlayerCache(),
                    storageManager: StorageManager.preview)
            ), shouldViewBeDismissed: .constant(true)
        )
    }
}
