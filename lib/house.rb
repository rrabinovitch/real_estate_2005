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

  def details
    house_details = {
      "price" => @price,
      "address" => @address
    }
  end

  def price_per_square_foot
    (@price.to_f / area).round(2)
  end

  def rooms_sorted_by_area
    rooms_by_area = (@rooms.sort_by { |room| room.area}).reverse
  end

  def rooms_by_category
    rooms_by_category = {}

    @rooms.map do |room|
      rooms_by_category[room.category] = rooms_from_category(room.category)
    end

    rooms_by_category
  end
end
