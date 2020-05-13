class Room
  attr_reader :category, :length, :width, :area

  def initialize(category, length = 10, width)
    @category = category
    @length = length
    @width = width
    @area = @length * @width.to_i
    @is_painted = false
  end

  def is_painted?
    @is_painted
  end

  def paint
    @is_painted = true
  end
end
