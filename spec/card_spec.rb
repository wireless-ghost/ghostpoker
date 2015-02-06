require 'spec_helper'

module Ghostpoker
  describe Card do
    it "returns the right value for a face card" do
      card = Card.new('c', 'K')
      expect(card.value).to eq 13
    end

    it "compare cards" do
      card = Card.new('c', '5')
      card1 = Card.new('h', 'A')
      expect(card1 > card).to eq true
    end
  end
end
