class House
  attr_reader :price, :address, :rooms

  def initialize(price, address)
    @price = price.gsub('$', '').to_i
    @address = address
    @rooms = []
  end

  def add_room(room)
    @rooms << room
  end

  def above_market_average?
    return true if @price > 500000
    false
  end

  def rooms_from_category(category)
    @rooms.find_all do |room|
      room.category == category
    end
  end

  def area
    house_area = 0

    @rooms.map do |room|
      house_area += room.area
    end

    house_area
  end
end
