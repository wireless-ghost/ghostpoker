require 'gosu'

class GameWindow < Gosu::Window
  def initialize
    super 692, 365, false
    self.caption = "Gosu Tutorial Game"

    @background_image = Gosu::Image.new(self, "assets/table.png", true)

    @kd = Card_Image.new(self, "KH")
    @kd.warp(320, 240)

    @qd = Card_Image.new(self, "QH")
    @qd.warp(230, 240)
  end

  def update
  end

  def draw
    @background_image.draw(0, 0, 0)
    @kd.draw
    @qd.draw
  end
end

class Card_Image
  def initialize(window, card_string)
    @image = Gosu::Image.new(window, "assets/#{card_string}.png", false)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def draw
    @image.draw(@x, @y, 0, 0.9, 0.9)
  end
end

window = GameWindow.new
window.show
