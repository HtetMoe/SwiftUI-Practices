//
//  MoonShot.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 08/07/2023.
//

import SwiftUI

struct MoonShot: View {
    let astronauts : [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let missions   : [Mission] = Bundle.main.decode("missions.json")
    
    //layout
    let columnsLayout = [ GridItem(.adaptive(minimum: 150)) ]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                
                LazyVGrid(columns: columnsLayout) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            //This is MonnShoot cell
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()

                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}

struct MoonShot_Previews: PreviewProvider {
    static var previews: some View {
        MoonShot()
    }
}
