require 'minitest/autorun'
require 'minitest/pride'
require './lib/room'
require './lib/house'

class HouseTest < Minitest::Test
  def test_it_exists
    house = House.new("$400000", "123 sugar lane")

    assert_instance_of House, house
  end

  def test_it_has_a_price
    house = House.new("$400000", "123 sugar lane")

    assert_equal 400000, house.price
  end

  def test_it_has_an_address
    house = House.new("$400000", "123 sugar lane")

    assert_equal "123 sugar lane", house.address
  end

  def test_it_has_no_rooms_by_default
    house = House.new("$400000", "123 sugar lane")

    assert_empty house.rooms
  end

  def test_rooms_can_be_added
    house = House.new("$400000", "123 sugar lane")
    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    house.add_room(room_1)
    house.add_room(room_2)

    assert_equal [room_1, room_2], house.rooms
  end

  def test_it_can_identify_if_above_market_average
    house_1 = House.new("$400000", "123 sugar lane")
    house_2 = House.new("$500000", "456 pepper street")
    house_3 = House.new("$500001", "789 salt avenue")

    assert_equal false, house_1.above_market_average?
    assert_equal false, house_2.above_market_average?
    assert_equal true, house_3.above_market_average?

  end

  def test_it_can_identify_rooms_of_each_category
    house = House.new("$400000", "123 sugar lane")

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    assert_equal [room_1, room_2], house.rooms_from_category(:bedroom)
    assert_equal [room_4], house.rooms_from_category(:basement)
    assert_equal [room_3], house.rooms_from_category(:living_room)
  end

  def test_it_can_calculate_house_area
    house = House.new("$400000", "123 sugar lane")

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    assert_equal 1900, house.area
  end

  def test_it_can_list_house_details
    house = House.new("$400000", "123 sugar lane")

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_1)
    house.add_room(room_2)
    house.add_room(room_3)
    house.add_room(room_4)

    house_details = {"price" => 400000, "address" => "123 sugar lane"}

    assert_equal house_details, house.details
  end

  def test_it_can_calculate_price_per_sq_ft
    house = House.new("$400000", "123 sugar lane")

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)

    assert_equal 210.53, house.price_per_square_foot
  end

  def test_it_can_sort_rooms_by_area
    house = House.new("$400000", "123 sugar lane")

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)

    assert_equal [room_4, room_3, room_2, room_1], house.rooms_sorted_by_area
  end

  def test_it_can_sort_rooms_by_category
    skip
    house = House.new("$400000", "123 sugar lane")

    room_1 = Room.new(:bedroom, 10, '13')
    room_2 = Room.new(:bedroom, 11, '15')
    room_3 = Room.new(:living_room, 25, '15')
    room_4 = Room.new(:basement, 30, '41')

    house.add_room(room_4)
    house.add_room(room_1)
    house.add_room(room_3)
    house.add_room(room_2)

    sorted_rooms = {
      :bedroom=>[room_1, room_2],
      :living_room=> [room_3],
      :basement=> [room_4]
    }
    assert_equal sorted_rooms, house.rooms_sorted_by_category
  end
end
