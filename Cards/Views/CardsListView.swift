//
//  CardsListView.swift
//  Cards
//
//  Created by Mikkela Wilson on 2/7/25.
//

import SwiftUI

struct CardsListView: View {
  @EnvironmentObject var store: CardStore
  @State private var selectedCard: Card?

  var body: some View {
    list
      .fullScreenCover(item: $selectedCard) { card in
        if let index = store.index(for: card) {
          SingleCardView(card: $store.cards[index])
        } else {
          fatalError("Unable to locate selected card")
        }
      }
  }

  var list: some View {
    ScrollView(showsIndicators: false) {
      VStack {
        ForEach(store.cards) { card in
          CardThumbnail(card: card)
            .onTapGesture {
              selectedCard = card
            }
        }
      }
    }
  }
}

struct CardsListView_Previews: PreviewProvider {
  static var previews: some View {
    CardsListView()
      .environmentObject(CardStore(defaultData: true))
  }
}
